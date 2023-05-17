## Configurar nome de usuário e senha

O env. variáveis ​​que você precisa configurar são:

> POSTGRES_USER -> usuário para acessar o banco
  POSTGRES_PASSWORD -> senha do usário
  POSTGRES_DB -> nome do banco de dados inicial
  DB_EXTENSION -> extensões como pgAdmin etc...
  POSTGRES_MULTIPLE_DATABASES -> caso esteja utilizando o plugin btree_gist poderá inicilizar multiplos bancos

## Vamos construi-lo

### Isso extrairá a versão mais recente do PostgreSQL do Docker Hub

```bash
docker-compose -f docker-compose.yml up -d
```

### Para verificar se o contêiner está em execução, podemos executar o seguinte comando no terminal. Isso listará todos os processos do Docker

```bash
docker ps
```

### Você deve ver algo semelhante a isso em seu terminal

```bash
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
h1c2ad243a0n        postgres:latest     "docker-entrypoint.s…"   5 min ago           Up 5 minutes        0.0.0.0:5432->5432/tcp   postgres_demo
```

### Caso precise parar o container novamente, você pode executar o seguinte comando dentro do seu terminal

```bash
docker stop <nome_do_container>
```
