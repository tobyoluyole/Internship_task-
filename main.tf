# using kubectl terraform provider to deploy the kubectl manifest to the kind cluster
terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
    
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
provider "kubectl" {
  load_config_file = true
  config_path = "./kubeconfig"

}

resource "kubectl_manifest" "my_deployment" {
   yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodejs-app
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nodejs-app
  template:
    metadata:
      labels:
        app: nodejs-app
    spec:
      containers:
      - name: nodejs-app
        image: pracricetobivincent/express-application
        ports:
        - containerPort: 3000
YAML
}
# setting up  monitoring and observability for the prometheus cluster.
provider "helm" {
  kubernetes {
    config_path = "./kubeconfig"
  }
}

# Install kube-prometheus-stack 
resource "helm_release" "monitoring" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
}
# creating the namespace monitoring 
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}
# Configuring the Prometheus to scrape itself
resource "kubernetes_manifest" "prometheus_scrape_config" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ConfigMap"
    "metadata" = {
      "name" = "prometheus-scrape-config"
      "namespace" = "monitoring"
      "labels" = {
        "kube-prometheus-stack-prometheus" = "true"
      }
    }
    "data" = {
      "prometheus.yml" = <<-EOT
        scrape_configs:
          - job_name: 'prometheus'
            static_configs:
              - targets: ['localhost:9090']
      EOT
    }
  }
}
