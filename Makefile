##################### INSTALL DEPENDENCIES #####################

# Download Kubectl
install-kubectl:
	@rm -fv kubectl
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	@chmod 777 kubectl

# Install the ArgoCD on minikube (* minikube installed is require before)
install-argocd:
	sh ./scripts/installations/install-argocd.sh

# Install Node js, Nvm (node version manager), Yarn
install-nodejs:
	sh ./scripts/installations/install-nodejs.sh \

install-minikube:
	sh ./scripts/installations/install-minikube.sh \

# Install minikube and cread default cluster
install-dependencies: install-nodejs install-minikube install-kubectl install-argocd

##################### RUNNING #####################

# Inicializa toda a infrestrutura, executando todos os docker-compose
run-infra:
	make docker-postgres
	make docker-backstage
	sh ./scripts/run-argocd.sh

##################### DOCKER #####################

# Inicializa apenas o banco Postgres
docker-postgres:
	docker-compose --env-file ./global-variables.env --file ./src/postgres/docker-compose.yml up -d --build -V

# Inicializa apenas o banco NoSQL Redis
docker-redis:
	docker-compose --env-file ./global-variables.env --file ./src/redis/docker-compose.yml up -d --build -V

# Inicializa apenas a aplicação Backstage.io
docker-backstage:
	cd ./src/backstage_io; echo "I'm in backstage_io"; \
	yarn install --frozen-lockfile; \
	yarn tsc; \
	yarn build:backend --config ./app-config.yaml; \
	docker image build . -f ./packages/backend/Dockerfile --tag backstage; \
	docker run --env-file ./../../global-variables.env -it -p 7007:7007 backstage;

# Tech docs to Backstage.io
docker-techdocs:
	cd ./src/tech-docs/techdocs-container; echo "I'm in techdocs folder"; \
	docker build . -t mkdocs:local-dev; \
	docker run -w /content -v $(pwd)/mock-docs:/content -p 8000:8000 -it mkdocs:local-dev serve -a 0.0.0.0:8000;

# Inicializa apenas a aplicação Gitlab
docker-gitlab:
	docker-compose --env-file ./global-variables.env --file ./src/gitlab/docker-compose.yml up -d --build -V

##################### GITLAB #####################

gitlab-get-admin-data:
	docker exec -it gitlab-web-idp grep 'Password:' /etc/gitlab/initial_root_password


##################### MINIKUBE #####################
run-minikube-dashboard:
	minikube dashboard
	
minikube-start:
	minikube start --driver=docker

##################### ARGOCD #####################

# Add new app on ArgoCd
argocd-add-app:
	${shell read -e -p "Enter path of *.yml file: " FILE_PATH ; echo FILE_PATH;}
# ${shell read -e -p "Enter path of *.yml file: " FILE_PATH}
# echo ${FILE_PATH}
# echo "Enter path of *.yml file: "
# read PATH_APP
# echo $PATH_APP "aquiiiii"
# kubectl apply -f path_app

