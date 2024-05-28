# Veirifcando utilização de recursos do docker
docker stats --no-stream

# Container especifico
docker stats --no-stream PostgresContainer

# Pare o container
docker stop NOME_DO_CONTAINER

# Remova o container
docker rm NOME_DO_CONTAINER

# Adicione citando os recursos
# A utlima palavra é a image
docker run -d --name PostgresContainer -p 5432:5432 -e POSTGRES_PASSWORD=dba --memory 2g --cpus 2 postgres
