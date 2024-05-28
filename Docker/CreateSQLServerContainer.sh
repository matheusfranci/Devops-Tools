# Install SQL Server Image
docker pull mcr.microsoft.com/mssql/server:2019-latest

### Install sqlcmd no docker host para conexão

# Importando o repositório publico
curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc

# Adicionando o repositório
add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/prod.list)"

# Instalando o SQLCMD
apt-get update
apt-get install sqlcmd

# criação do container
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=23031919Mf!" \
   -p 1433:1433 --name sqlserver19 --hostname sqlserver19 \
   -d \
   --memory 4g \
   mcr.microsoft.com/mssql/server:2019-latest
   
# Conectando no sql server
sudo docker exec -it sql1 "bash"
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "suasenha"
