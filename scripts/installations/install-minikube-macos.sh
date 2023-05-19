echo "###############################################################"
echo "#########           INSTALL MINIKUBE   MACOS          #########"
echo "###############################################################"

brew install docker-machine-driver-xhyve

### Set root to Minikube docker-machine-driver-xhyve need root owner and uid 
sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve


### Configuring ###
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 && \
chmod +x minikube && \
sudo mv minikube /usr/local/bin/
curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit \
&& chmod +x docker-machine-driver-hyperkit \
&& sudo mv docker-machine-driver-hyperkit /usr/local/bin/ \
&& sudo chown root:wheel /usr/local/bin/docker-machine-driver-hyperkit \
&& sudo chmod u+s /usr/local/bin/docker-machine-driver-hyperkit

## Start minikube ##
minikube start --logtostderr --v=3 --vm-driver=hyperkit
minikube version
minikube ssh

docker version
kubectl config get-contexts