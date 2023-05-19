echo "###############################################################"
echo "#########           START ARGO CD                     #########"
echo "###############################################################"

## Start minikube ##
minikube start --logtostderr --v=3 --vm-driver=hyperkit
minikube version
minikube ssh