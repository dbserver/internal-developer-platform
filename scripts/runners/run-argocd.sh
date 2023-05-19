echo "###############################################################"
echo "#########           START ARGO CD                     #########"
echo "###############################################################"

echo ">>>>>>> !!!! Important: Store the token temporarily somewhere, which will be used in the next section for our portal-ArgoCD integration." &&
echo "ArgoCd user: admin" &&
echo "ArgoCd password:  " && kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo &&

echo ">>>>>>> ################################################ <<<<<<<<" &&
kubectl port-forward svc/argocd-server -n argocd 8080:443