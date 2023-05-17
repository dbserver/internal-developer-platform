if ! [ -x "$(command -v kubectl)" ]; then
  echo "kubectl is required to install ArgoCd"
  exit
else
    if ! [ -x "$(command -v minikube)" ]; then
        echo "minikube is required to install ArgoCd"
        exit
    else
        if ! [ -x "$(command kubectl get namespace argocd)" ]; then
            echo "ArgoCd already installed!!"
            exit
        fi
    
        echo "Creating the "argocd" namespace in mikube...."
        kubectl create namespace argocd
        kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

        echo "Forwarding the Argo CD server to our local 8080 port so that we can access it..."
        kubectl port-forward svc/argocd-server -n argocd 8080:443

        echo "Let's initialize the password for the admin user!"
        argocd admin initial-password
        argocd login localhost:8080
        argocd account update-password

        echo "Creating an Argo CD project role in the "default" project and an API token..."
        argocd proj role create default backstage
        argocd proj role create default backstage
        argocd proj role create-token default backstage

        echo "!!!! Important: Store the token temporarily somewhere, which will be used in the next section for our portal-ArgoCD integration."

        echo "Enable Argo CD role-based access control (RBAC)..."
        kubectl edit configmap argocd-rbac-cm
    fi
fi
