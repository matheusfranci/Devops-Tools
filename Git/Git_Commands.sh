#Entre na pasta desejada
cd C:\Users\Matheus\Mongodb_scripts

#Inicie o Git
git init

#Adicione o arquivo sql
PS C:\Users\Matheus\Mongodb_scripts> git add Comandos_Basicos.sql

#Faça o commit com um comentário entre aspas
PS C:\Users\Matheus\Mongodb_scripts> git commit -m "first commit"

#Verifique a branch
PS C:\Users\Matheus\Mongodb_scripts> git branch
* master

#Adicionando um repositório remoto
PS C:\Users\Matheus\Mongodb_scripts> git remote add origin https://github.com/matheusfranci/Mongodb.git

#Fazendo um push no repositório remoto na branch master
PS C:\Users\Matheus\Mongodb_scripts> git push -u origin master
