# internal-developer-platform
Repositorio com uma implementação de plataforma interna para desenvolvedores

## Dependencies

- minikube
- PostgreSQL
- ArgoCD CLI
- Github
- Backstage.io


## PostgreSQL
```bash
docker run --name developer-portal-db -e POSTGRES_PASSWORD=db-dev-portal -p 5432:5432 -d postgres
```

## Minikube

### start docker driver
```bash
minikube start --driver=docker
```

## ArgoCD

### install ArgoCD
```bash
# creating namespace
kubectl create namespace argocd

# install ArgCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### Running ArgoCD
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

### Change ArgoCD password
```bash
argocd admin initial-password
argocd login localhost:8080
argocd account update-password
```

### Create an Argo CD project role in the “default” project and an API token
```bash
argocd proj role create default backstage
argocd proj role create default backstage
argocd proj role create-token default backstage

## sample output

Create token succeeded for proj:default:backstage.
  ID: 06203eaa-8048-440f-9c42-1a522cf1e522
  Issued At: 2023-04-11T17:51:58-03:00
  Expires At: Never
  Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcmdvY2QiLCJzdWIiOiJwcm9qOmRlZmF1bHQ6YmFja3N0YWdlIiwibmJmIjoxNjgxMjQ2MzE4LCJpYXQiOjE2ODEyNDYzMTgsImp0aSI6IjA2MjAzZWFhLTgwNDgtNDQwZi05YzQyLTFhNTIyY2YxZTUyMiJ9.n1M52JzzL74PKCtNlhw3eJKvZ8Pnr-vWMyeikNshcj4

```

### Enable Argo CD role-based access control (RBAC)
```bash
kubectl edit configmap argocd-rbac-cm
```

### Add the “data” part using the following content:
```bash
data:
  policy.csv: |
    p, role:org-admin, applications, *, */*, allow
    p, role:org-admin, clusters, get, *, allow
    p, role:org-admin, repositories, get, *, allow
    p, role:org-admin, repositories, create, *, allow
    p, role:org-admin, repositories, update, *, allow
    p, role:org-admin, repositories, delete, *, allow
    p, role:backstage, applications, *, */*, allow
  policy.default: role:readonly
```

### Create env variable to ArgoCD token
```bash
export ARGOCD_AUTH_TOKEN="argocd.token=YOUR_ARGOCD_ROLE_API_TOKEN_HERE
```

# Kubernetes commands (help)    

```bash
# set namespace
kubectl config set-context --current --namespace=<insert-namespace-name-here>

# check namespace
kubectl config view --minify | grep namespace:

# connect shell to running container
kubectl exec --stdin --tty <pod-name> -- /bin/bash
```

