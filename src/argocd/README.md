
[Getting Started with Argo CD on Docker Desktop](https://collabnix.com/getting-started-with-argocd-on-docker-desktop/)

## Componente do Argo CD

### - API Server ( pod: argcocd-server)

Controla toda a instância do ArgoCD, todas as suas operações, autenticação e acesso a segredos que são armazenados como segredos do Kubernetes, etc.

### - Repository Server ( pod: argocd-repo-server)

Armazena e sincroniza dados de repositórios Git configurados e gera manifestos do Kubernetes

### - Application Controller ( pod: argocd-application-controller)

Usado para monitorar aplicativos em um cluster Kubernetes para torná-los iguais aos descritos em um repositório e controlar ganchos de pré-sincronização, sincronização e pós-sincronização

## Começando

### Step 1. Criar um novo namespace

Create a namespace argocd where all ArgoCD resources will be installed

```bash
kubectl create namespace argocd
```

### Step 2. Instalar recursos ArgoCD resources

```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
 
kubectl get po -n argocd
```

### Step 3. Verifique se todos os pods estão funcionando

```bash
kubectl get po -n argocd
```

### Step 4. Configurando o encaminhamento de porta para acesso ao painel

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```

### Step 5. Fazendo login

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

### Step 6. Instale o argoCD CLI no Mac usando o Homebrew

```bash
brew install argocd
```

### Step 7. Acesse o servidor Argo CD API

```bash
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
service/argocd-server patched
```

### Step 8. Entrar no ArgoCD

```bash
% argocd account update-password

## output
*** Enter password of currently logged in user (admin):                       
*** Enter new password for user admin: 
*** Confirm new password for user admin: 
Password updated
Context 'localhost' updated
ajeetraina@Ajeets-MacBook-Pro ~ % 
```

### Step 10. Registrar um cluster para implantar aplicativos

```bash
argocd cluster add docker-desktop
```

### Step 11. Implantar um aplicativo de amostra

O repositório [ArgoCD GitHub](https://github.com/argoproj/argocd-example-apps) contém aplicativos de exemplo para demonstração da funcionalidade ArgoCD. Você pode registrar este repositório em sua instância ArgoCD ou bifurcar este repositório e enviar seus próprios commits para explorar ArgoCD e GitOps!

Vamos pegar o aplicativo de exemplo da loja de meias para nosso propósito de demonstração.

### Step 12.1 Verifique o aplicativo existente, se houver

```bash
argocd app list   
```

Step 12.2 Deploy a Sock Shop app

```bash
argocd app create sockshop --repo https://github.com/argoproj/argocd-example-apps.git  --path sock-shop --dest-server https://kubernetes.default.svc --dest-namespace default
```

### Step 13. Listando o aplicativo de amostra

```bash
argocd app list 
```
