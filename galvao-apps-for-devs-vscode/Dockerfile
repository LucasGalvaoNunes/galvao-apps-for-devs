FROM codercom/code-server:4.98.0@sha256:49190032f1ab73cdcd0c930b1e961c20110aa1b6004d296c14681eb11c9f49d8

# Instalar Docker CLI
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# Iniciar o container como usuário 1000:1000
USER "1000:1000"
