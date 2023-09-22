# Configure Kubernetes provider to use Kind kubeconfig
provider "kubernetes" {
  config_path = "./kubeconfig"
}

# Read in the manifest file data
data "local_file" "deployment_yaml" {
  filename = "./deployment.yaml"
}

# Deploy the manifest data 
resource "kubernetes_manifest" "apply_deployment" {
  manifest = yamldecode(data.local_file.deployment_yaml.content)
}



