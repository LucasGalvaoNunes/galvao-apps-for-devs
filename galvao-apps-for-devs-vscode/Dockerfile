# Usar a imagem oficial do code-server
FROM codercom/code-server:latest

# Instalar o docker.io no container
USER root
RUN apt-get update && apt-get install -y docker.io && rm -rf /var/lib/apt/lists/*

# Voltar para o usuário coder
USER coder
