## No servidor ansible gere a chave ssh com o usuario que será usado para os processos e ssh
ssh-keygen

: '
mat@ansibleserver:~$ ssh-keygen
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/mat/.ssh/id_ed25519):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/mat/.ssh/id_ed25519
Your public key has been saved in /home/mat/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:xaBoXaT8V3GUdRLXo52CjgM+dfZd0Wgpy2GYWKF7WXQ mat@ansibleserver
The key's randomart image is:
+--[ED25519 256]--+
|       .+oo+o.E**|
|     + +dhsjhlds==+|
|    o = . oo+=o +|
|   .   o + Boo o.|
|      . S O . o .|
|       o = . . . |
|        . .      |
|                 |
|                 |
+----[SHA256]-----+
'

## Acesse o diretório do arquivo gerado e copie para o servidor remoto onde o ansible irá acessar, segue exemplo:
cd /home/mat/.ssh/
ssh-copy-id mat@111.111.1.11
: '
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/mat/.ssh/id_ed25519.pub"
The authenticity of host '111.111.1.11 (111.111.1.11)' can't be established.
ED25519 key fingerprint is SHA256:tW3mFkvyJ1TaSA/nxhLcO3Z70lt0WuytUFgLNKS7sS0.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
mat@111.111.1.11's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'mat@111.111.1.11'"
and check to make sure that only the key(s) you wanted were added.
'
## Teste de acesso
mat@ansibleserver:~/.ssh$ ssh mat@111.111.1.11
Welcome to Ubuntu 24.04 LTS (GNU/Linux 6.8.0-31-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of dom 26 mai 2024 01:09:54 UTC

  System load:             0.0
  Usage of /:              32.8% of 18.53GB
  Memory usage:            8%
  Swap usage:              0%
  Processes:               137
  Users logged in:         1
  IPv4 address for enp0s3: 111.111.1.11
  IPv6 address for enp0s3: 2804:d88:8087:ejkjejk0:a00:27ff:fe95:8cad

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Manutenção de Segurança Expandida para Applications não está ativa.

10 as atualizações podem ser aplicadas imediatamente.
Para ver as actualizações adicionais corre o comando: apt list --upgradable

Ativar ESM Apps para poder receber possiveis futuras atualizações de segurança.
Consulte https://ubuntu.com/esm ou execute: sudo pro status


Last login: Sun May 26 00:36:35 2024 from 111.111.1.11
mat@gitserver:~$ logout
Connection to 111.111.1.11 closed.

## Sucesso, agora é só fazer o mesmo em todos.


