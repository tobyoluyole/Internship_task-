# Solution to the internship task 
The mini projects runs a bash script to deploy a kind cluster locally. 
Once the kind cluster is up and running and the kubeconfig file has been downloaded. 
A dockerized hello world express appliation is deployed to cluster using  kubectl terraform provider.
Once the pod is up and running, the kube-prometheus stack with the terraform helm provider are used to set up monitoring and observability for the prometheus cluster.
I also added another file called the kubernetes.tf, another way for the dockerized hello world express appliation to be deployed into the cluster
I decided to try it out because it allows using the kubectl manifest file as a whole i.e you don't have to script it with the terraform code  
