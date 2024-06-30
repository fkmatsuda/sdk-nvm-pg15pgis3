# Usando Debian stable-slim como imagem base
FROM debian:stable-slim

# Evitar interações durante a instalação de pacotes
ENV DEBIAN_FRONTEND=noninteractive

# Definindo argumentos para versões do Java, Node.js, Maven e versões específicas do PostgreSQL e PostGIS
ENV JAVA_VERSION="11.0.23-zulu" 
ENV NODE_VERSION=lts/iron
ENV MAVEN_VERSION=3.9.8
ENV POSTGRES_VERSION=15
ENV POSTGIS_VERSION=3

# Definindo parâmetros de configuração do PostgreSQL
ENV PGDATA=/database
ENV DB_HOST=localhost
ENV DB_PORT=5432
ENV DB_USER=qgis
ENV DB_PASSWORD=qgis

# Definindo parâmetros de configuração do S3
ENV ENDPOINT_URL=https://s3.amazonaws.com
ENV ACCESS_KEY_ID=access
ENV SECRET_ACCESS_KEY=secret


# Atualizar lista de pacotes e instalar dependências necessárias
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y curl wget gnupg2 lsb-release ca-certificates git build-essential zip unzip libasound2 libxi6 libxtst6 apt-utils p7zip-full libfontconfig1 libxrender1 gnupg2 lsb-release s4cmd openssh-client

# Adicionando o repositório oficial do PostgreSQL
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Atualizar lista de pacotes com o novo repositório e instalar PostgreSQL e PostGIS
RUN apt-get update && \
    apt-get install -y --install-recommends postgresql-${POSTGRES_VERSION} postgresql-${POSTGRES_VERSION}-postgis-${POSTGIS_VERSION}

# Instalar SDKMAN, Java e Maven
RUN curl -s "https://get.sdkman.io" | bash

# Instalar NVM e Node.js
ENV NVM_DIR=/usr/local/nvm

RUN mkdir -p $NVM_DIR && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Limpar cache de pacotes para reduzir tamanho da imagem
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copiando arquivos de configuração e inicialização
COPY postgres/pg_hba.conf /pg_hba.conf
COPY postgres/pginit.sql /pginit.sql
COPY postgres/init_db.sh /init_db.sh
COPY dev/init_dev.sh /init_dev.sh
COPY common/init_all.sh /init_all.sh

ENV MAVEN_HOME=/root/.sdkman/candidates/maven/current
ENV JAVA_HOME=/root/.sdkman/candidates/java/current
ENV NODE_HOME=$NVM_DIR/versions/node/$NODE_VERSION

ENV PATH=$MAVEN_HOME/bin:$JAVA_HOME/bin:$NODE_HOME/bin:$NVM_DIR:$PATH

ENTRYPOINT [ "/init_all.sh" ]

CMD [ "echo", "Ready!" ]