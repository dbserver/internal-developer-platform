echo "###############################################################"
echo "#########           INSTALL MINIKUBE                  #########"
echo "###############################################################"

if ! [ -x "$(command -v kubectl)" ]; then
  echo "Installing kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
else
  echo "kubectl is already installed"
fi

if ! [ -x "$(command -v minikube)" ]; then
  echo "Installing minikube..."
  curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.28.2/minikube-linux-amd64
  chmod +x minikube
  sudo cp minikube /usr/local/bin/

  echo "Configuring minikube..."
  minikube config set ShowBootstrapperDeprecationNotification false
  minikube config set WantUpdateNotification false
  minikube config set WantReportErrorPrompt false
  minikube config set WantKubectlDownloadMsg false
else
  echo "minikube is already installed"
fi

echo "Starting minikube..."
sudo /usr/local/bin/minikube --vm-driver=none --bootstrapper=localkube start

set tempFolder=$PWD

cd ~

rm .kube -rf
rm .minikube -rf

sudo mv /root/.kube $HOME/
sudo chown -R $USER $HOME/.kube
sudo chgrp -R $USER $HOME/.kube

sudo mv /root/.minikube $HOME/
sudo chown -R $USER $HOME/.minikube
sudo chgrp -R $USER $HOME/.minikube

cd $tempFolder

sed -i "s:/root/:/home/$USER/:g" $HOME/.kube/config