# Verificando images
docker images

# Clone os repositórios do github
git clone https://github.com/oracle/docker-images.git

# Execute o sh passando a versão e o e de enterprise edition
cd docker-images/OracleDatabase/SingleInstance/dockerfiles
./buildContainerImage.sh -v 19.3.0 -e

# Caso execute esse comando sem os binários do oracle o erro abaixo será exibido
: '
Checking Docker version.
Dockerfile
Checking if required packages are present and valid...
md5sum: LINUX.X64_193000_db_home.zip: No such file or directory
LINUX.X64_193000_db_home.zip: FAILED open or read
md5sum: WARNING: 1 listed file could not be read
MD5 for required packages to build this image did not match!
Make sure to download missing files in folder 19.3.0.
'

# Baixe o zip do oracle, copie para o servidor docker e mova para a pasta indicada
mv /home/mat/LINUX.X64_193000_db_home.zip /root/docker-images/OracleDatabase/SingleInstance/dockerfiles/19.3.0/

# Execute o comando abaixo 
./buildContainerImage.sh -v 19.3.0 -e

# Ultimas linhas do log de install
: '
Building image 'oracle/database:19.3.0-ee' ...
[+] Building 356.7s (15/15) FINISHED                                                                                                                                                   docker:default
 => [internal] load build definition from Dockerfile                                                                                                                                             0.1s
 => => transferring dockerfile: 5.06kB                                                                                                                                                           0.0s
 => [internal] load metadata for docker.io/library/oraclelinux:7-slim                                                                                                                            1.9s
 => [internal] load .dockerignore                                                                                                                                                                0.1s
 => => transferring context: 2B                                                                                                                                                                  0.0s
 => [base 1/4] FROM docker.io/library/oraclelinux:7-slim@sha256:40acb375743853eb51948abbd8dd907f6e47cb368aa8da958cfd2fc5b36f71ce                                                                16.2s
 => => resolve docker.io/library/oraclelinux:7-slim@sha256:40acb375743853eb51948abbd8dd907f6e47cb368aa8da958cfd2fc5b36f71ce                                                                      0.0s
 => => sha256:40acb375743853eb51948abbd8dd907f6e47cb368aa8da958cfd2fc5b36f71ce 547B / 547B                                                                                                       0.0s
 => => sha256:3bbaf6342e9f5d6aef40005a8e613535688d8870f3d92e640996bff19ae51b28 529B / 529B                                                                                                       0.0s
 => => sha256:970e50328c70a33ed558068ed168446105a0f9b6d78b8bcff5fa3423723c2779 1.48kB / 1.48kB                                                                                                   0.0s
 => => sha256:9ff90099b5a4df32952d1822d472a72c931c53a68c05a3ba7431ea0f85d54135 50.39MB / 50.39MB                                                                                                 3.4s
 => => extracting sha256:9ff90099b5a4df32952d1822d472a72c931c53a68c05a3ba7431ea0f85d54135                                                                                                       11.0s
 => [internal] load build context                                                                                                                                                               38.5s
 => => transferring context: 3.06GB                                                                                                                                                             38.3s
 => [base 2/4] COPY setupLinuxEnv.sh checkSpace.sh /opt/install/                                                                                                                                 1.0s
 => [base 3/4] COPY runOracle.sh startDB.sh createDB.sh createObserver.sh dbca.rsp.tmpl setPassword.sh checkDBStatus.sh runUserScripts.sh relinkOracleBinary.sh configTcps.sh /opt/oracle/       0.3s
 => [base 4/4] RUN chmod ug+x /opt/install/*.sh &&     sync &&     /opt/install/checkSpace.sh &&     /opt/install/setupLinuxEnv.sh &&     rm -rf /opt/install                                   34.4s
 => [builder 1/2] COPY --chown=oracle:dba LINUX.X64_193000_db_home.zip db_inst.rsp installDBBinaries.sh /opt/install/                                                                            8.2s
 => [builder 2/2] RUN chmod ug+x "/opt/install"/*.sh &&     sync &&     "/opt/install"/"installDBBinaries.sh" ee                                                                               139.6s
 => [stage-2 1/4] COPY --chown=oracle:dba --from=builder /opt/oracle /opt/oracle                                                                                                                42.3s
 => [stage-2 2/4] RUN "/opt/oracle"/oraInventory/orainstRoot.sh &&     "/opt/oracle/product/19c/dbhome_1"/root.sh                                                                                1.5s
 => [stage-2 3/4] WORKDIR /home/oracle                                                                                                                                                           0.2s
 => [stage-2 4/4] RUN echo 'ORACLE_SID=${ORACLE_SID:-ORCLCDB}; export ORACLE_SID=${ORACLE_SID^^}' > .bashrc                                                                                      0.4s
 => exporting to image                                                                                                                                                                          58.8s
 => => exporting layers                                                                                                                                                                         58.7s
 => => writing image sha256:ea654d8a36ce17308ad4c078b58dd630624ea43e5267af944fd80067dcf069b0                                                                                                     0.0s
 => => naming to docker.io/oracle/database:19.3.0-ee                                                                                                                                             0.0s


  Oracle Database container image for 'ee' version 19.3.0 is ready to be extended:

    --> oracle/database:19.3.0-ee

  Build completed in 357 seconds.
'

# Listando imagens para validação
root@dockerserver:/u02/docker-images/OracleDatabase/SingleInstance/dockerfiles# docker images
REPOSITORY        TAG         IMAGE ID       CREATED         SIZE
oracle/database   19.3.0-ee   ea654d8a36ce   3 minutes ago   6.54GB

# Montagem do container + Criação do banco
docker run \
--name oracle19c \
-p 1521:1521 \
-p 5500:5500 \
-e ORACLE_PDB=orcl \
-e ORACLE_PWD=password \
-e INIT_SGA_SIZE=4096 \
-e INIT_PGA_SIZE=512 \
-v /opt/oracle/oradata \
-d \
oracle/database:19.3.0-ee

# Acessando o container 
docker exec -u 0 -it hsdhdfjhsdjkl /bin/bash

# Instalando o vi para configuração dos arquivos de conexão
yum install vi

# Modificando o sqlnet.ora e tnsnames.ora
vi $ORACLE_HOME/network/admin/sqlnet.ora

SQLNET.ALLOWED_LOGON_VERSION_SERVER=10

-- Leia o tnsnames.ora se estiver similar ao de baixo não edite
cat $ORACLE_HOME/network/admin/tnsnames.ora

ORCLCDB=localhost:1521/ORCLCDB
ORCL= 
(DESCRIPTION = 
  (ADDRESS = (PROTOCOL = TCP)(HOST = 0.0.0.0)(PORT = 1521))
  (CONNECT_DATA =
    (SERVER = DEDICATED)
    (SERVICE_NAME = ORCL)
  )
)


# Faça o mesmo para o listener.ora, s[o modifique caso esteja diferente disso:
cat /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora

LISTENER = 
(DESCRIPTION_LIST = 
  (DESCRIPTION = 
    (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1)) 
    (ADDRESS = (PROTOCOL = TCP)(HOST = 0.0.0.0)(PORT = 1521)) 
    (CONNECT_DATA = (SERVICE_NAME = orcl)) 
  ) 
)

DEDICATED_THROUGH_BROKER_LISTENER=ON
DIAG_ADR_ENABLED = off

# Conecte no banco 
sqlplus sys/password@orcl as sysdba
