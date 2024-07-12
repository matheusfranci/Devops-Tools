-- Listando todos os containers, incluindo os offline
docker container ls -a

-- Iniciando container docker
docker start container_name

-- Acessando um container
docker exec -it meu_container /bin/bash

-- Parando o container 
docker stop container_name
