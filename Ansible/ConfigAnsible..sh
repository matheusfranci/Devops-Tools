## Acesse o arquivo /etc/ansible/hosts
vi /etc/ansible/hosts

## Adicione ao final os hosts, lembrando que o requisito para o ansible é o ssh e a comunicação entre os hosts mencionados nesse arquivo.
[servers]
hostname1 ansible_host=203.0.113.111
hostname2 ansible_host=203.0.113.112
hostname3 ansible_host=203.0.113.113

[all:vars]
ansible_python_interpreter=/usr/bin/python3

-- Validação da adição dos hosts
ansible-inventory --list -y

: '
mat@ansibleserver:/etc/ansible$ ansible-inventory --list -y
all:
  children:
    servers:
      hosts:
        dockerserver:
          ansible_host: 192.168.1.17
          ansible_python_interpreter: /usr/bin/python3
        gitserver:
          ansible_host: 192.168.1.15
          ansible_python_interpreter: /usr/bin/python3

'

## Verificando em todos os hosts o espaço em disco
mat@ansibleserver:/etc/ansible$ ansible all -a "df -h"
dockerserver | CHANGED | rc=0 >>
Filesystem                         Size  Used Avail Use% Mounted on
tmpfs                              392M  1,1M  391M   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv   19G  6,1G   12G  35% /
tmpfs                              2,0G     0  2,0G   0% /dev/shm
tmpfs                              5,0M     0  5,0M   0% /run/lock
/dev/sda2                          2,0G   95M  1,7G   6% /boot
tmpfs                              392M   12K  392M   1% /run/user/1000
gitserver | CHANGED | rc=0 >>
Filesystem                         Size  Used Avail Use% Mounted on
tmpfs                              392M  1,1M  391M   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv   19G  6,1G   12G  35% /
tmpfs                              2,0G     0  2,0G   0% /dev/shm
tmpfs                              5,0M     0  5,0M   0% /run/lock
/dev/sda2                          2,0G   95M  1,7G   6% /boot
tmpfs                              392M   12K  392M   1% /run/user/1000

## Adição de variaveis no arquivo de configuração do ansible
vi /etc/ansible/ansible.cfg

[defaults]
host_key_checking=false
roles_path= /etc/ansible/roles
remote_user=mat
ansible_user=mat
ansible_ssh_user=mat
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

## Após isso salve. Lembrando que essas variáveis são necessárias em uma configuração not default, nesse caso eu tirei o root do processo
