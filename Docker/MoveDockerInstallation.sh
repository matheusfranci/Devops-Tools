# Parando serviço docker
sudo systemctl stop docker
sudo systemctl stop docker.socket
sudo systemctl stop containerd

# Crie o diretório destino
sudo mkdir -p /new_dir_structure

# Movendo do atual para o novo
sudo mv /var/lib/docker /new_dir_structure

# Esrevendo em um json de conf
sudo vim /etc/docker/daemon.json

# Adicione isso no arquivo vazio
{
  "data-root": "/new_dir_structure/docker"
}

# Inicie o serviço
systemctl start docker

# Validando o diretório
docker info -f '{{ .DockerRootDir}}'
