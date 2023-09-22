# Solution to the internship task 
The mini projects runs a bash script to deploy a kind cluster locally. 
After the kind cluster is up and running and the kubeconfig file has been downloaded, 
a dockerized hello world express appliation is deployed to cluster using  kubectl terraform provider
After the pod is up and running the kube-prometheus stack and the terraform helm provider are used to set up monitoring and observability for the prometheus cluster.
I also added another file called the kubernetes.tf, another way to the dockerized hello world express appliation. 
I decided to try it out because it allows using the kubernetes file as a whole i.e you don't have to script it with the terraform code  
