<p align="center">
    ![logo_db_idp](https://github.com/dbserver/internal-developer-platform/assets/7014252/8a3cba58-56e4-4d0f-aba2-bb023ab1650d)
</p>


Tabela de conteúdos
=================
<!--ts-->
* [Descrição do projeto](#descrição-do-projeto)
* [Pré-requisitos](#-pré-requisitos)
* [Tecnologias](#-tecnologias)
* [Iniciando o uso deste projeto](#-iniciando-o-uso-deste-projeto)
    * [Clone este repositório](#clone-este-repositório)
    * [Acesse a pasta do projeto no terminal/cmd](#acesse-a-pasta-do-projeto-no-terminalcmd)
    * [Instale as dependências](#instale-as-dependências)
    * [Execute a aplicação](#execute-a-aplicação)
* [Arquitetura do projeto](#-arquitetura-do-projeto)
* [Banco de dados](#-banco-de-dados)
  * [Instalando o banco de dados PostgreSQL](#instalando-o-banco-de-dados-PostgreSQL)
  * [Executando o banco de dados com docker compose](#executando-o-banco-de-dados-com-docker)
  * [Cliente para gerenciamento do banco de dados PostgreSQL](#cliente-para-gerenciamento-do-banco-de-dados-PostgreSQL)
* [Sobre padrões no versionamento do código](#sobre-padrões-no-versionamento-do-código)
<!--te-->

#

## Descrição do Projeto

Implementação do Backstage demonstrando a utilização das core features:
- Backstage TechDocs
- Backstage Software catalog
- Backstage Kubernetes
- Backstage Search
- Backstage Software Templates

## 👍 Pré-requisitos

Como pré requisitos temos os seguintes itens:
- Minikube
- Docker
- NodeJS
- ArgoCD

## 🛠 Tecnologias

As seguintes ferramentas foram usadas na construção do projeto:

- [Makefile](https://www.gnu.org/software/make/manual/make.html)
- [Yarn](https://yarnpkg.com/)
- [Docker](https://docs.docker.com/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux)
- [ArgoCD](https://argoproj.github.io/cd/)
- [Backstage](backstage.io)

## 🎬 Iniciando o uso deste projeto

### Clone este repositório
```bash
git clone git@github.com:dbserver/internal-developer-platform.git
```

### Acesse a pasta do projeto no terminal/cmd
```bash
cd internal-developer-platform
```

### Instale as dependências
```bash
make install-dependencies
```

### Iniciando os recursos de infraestrutura
```bash
make run-infra
```

### Execute a aplicação core features
```bash
make docker-techdocs
```

### O servidor do backstage iniciará na porta:7007 - acesse <http://localhost:7007>

## Acesso ao TechDocs

Para acessar a TechDocs acesse o link abaixo;
```
http://localhost:8000
```


## 📁 Arquitetura do projeto

A arquitetura do projeto é dividida em aplicações com responsabilidades distintas:

### Camada de apresentação (Backstage)
A aplicação é apartada e de acordo com suas customizações deve-se buildar a imagem e alocar recursos conforme a demanda, seu frontend e backend são dividos em pastas no repositório __src/backstage_io__, incluindo seus plugins e tudo pertinente ao Projeto [Backstage](backstage.io)

### Camada de GitOps (ArgoCD)
Visando orquestrar os serviços de maneira homogênea o ArgoCD nos dará flexibilidade necessária diminuindo esforço administrativo.

### Camada de acesso a dados (Data)
A responsabilidade dessa camada é limitada às operações Criar, Recuperar, Atualizar e Excluir (CRUD) em uma fonte de dados, que geralmente é um banco de dados relacional ou não relacional. As classes de repositório geralmente são colocadas em um pacote de repositório.


## 🏬 Banco de dados

### Instalando o banco de dados PostgreSQL

- Visando abstrair o processo de infraestrutura foi criado no Makefile na raiz do projeto o processo de instalação e instanciação do banco da dados PostgreSQL
 
```bash
# Para sistemas unix
make docker-postgres
```
## Executando o banco de dados com docker compose
```bash
docker-compose --env-file ./global-variables.env --file ./src/postgres/docker-compose.yml up -d --build -V
```
**No comando dado acima,**

- postgres-idp é o nome do Docker Container.
 - --env-file Contém as variáveis necessárias para deployment
 - -p 5432:5432 é o parâmetro que estabelece uma conexão entre a porta do host e a porta do contêiner do Docker. Nesse caso, ambas as portas são fornecidas como 5432, o que indica que as solicitações enviadas às portas do host serão redirecionadas automaticamente para a porta do contêiner do Docker. Além disso, 5432 também é a mesma porta onde o PostgreSQL estará aceitando requisições do cliente.
-  --file é o parâmetro que invoca o arquivo yaml do docker compose para orquestrar seus containers.

**Para validar se o banco de dados foi executado com sucesso execute o comando abaixo**
- 
```bash
 docker ps --filter "name=postgres-idp"
```
**Deve ser exibido algo similar o abaixo**
```
CONTAINER ID   IMAGE      COMMAND                  CREATED         STATUS         PORTS                    NAMES
f33be708db53   postgres   "docker-entrypoint.s…"   4 minutes ago   Up 4 minutes   0.0.0.0:5432->5432/tcp   postgres-idp
```

## Cliente para gerenciamento do banco de dados PostgreSQL
Para gerenciar, executar scripts sugerimos a utilização do [DBeaver](https://dbeaver.io/download/)

## Sobre padrões no versionamento do código

É desejado que seja utilizado o padrão de Commits Semânticos. Pode entender melhor [nesse link](https://github.com/iuricode/padroes-de-commits)
