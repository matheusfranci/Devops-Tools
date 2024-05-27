# Verificação
root@dockerserver:/etc/apt/keyrings# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
root@dockerserver:/etc/apt/keyrings#

# Instalaçao container postgres
root@dockerserver:/etc/apt/keyrings# docker pull postgres
Using default tag: latest
latest: Pulling from library/postgres
09f376ebb190: Pull complete
119215dfb3e3: Pull complete
e02bbc8c8252: Pull complete
061f31803c55: Pull complete
accd4903f49a: Pull complete
2016ff8e6e3a: Pull complete
088e651df7e9: Pull complete
ed155773e5e0: Pull complete
ffebb35d2904: Pull complete
293f0bec643a: Pull complete
1655a257a5b5: Pull complete
4ddba458499d: Pull complete
90e48ae03559: Pull complete
822c1a513e6a: Pull complete
Digest: sha256:1bf73ccae25238fa555100080042f0b2f9be08eb757e200fe6afc1fc413a1b3c
Status: Downloaded newer image for postgres:latest
docker.io/library/postgres:latest

# Criação e configuração
docker run -d --name PostgresContainer -p 5432:5432 -e POSTGRES_PASSWORD=dba postgres

# Verificação
root@dockerserver:/etc/apt/keyrings# docker ps
CONTAINER ID   IMAGE      COMMAND                  CREATED         STATUS         PORTS                                       NAMES
e4fba4dd305c   postgres   "docker-entrypoint.s…"   4 seconds ago   Up 3 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   PostgresContainer

# Acessando o container
docker exec -it postgresCont bash

# Acessando o psql
psql -h localhost -U postgres
