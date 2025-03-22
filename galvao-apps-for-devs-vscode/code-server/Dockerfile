FROM codercom/code-server:4.98.2@sha256:9ed588a05d4e81aa464e753a409bc3b2b93267323d1c3975fbddf6f9aef84c26

# Atualiza pacotes base
USER root
RUN apt-get update && apt-get upgrade -y

# ----------------------
# Instala dependências comuns
# ----------------------
RUN apt-get install -y curl wget gnupg2 software-properties-common lsb-release sudo apt-transport-https ca-certificates

# ----------------------
# Instala o Node.js via NVM
# ----------------------
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash && \
    . "$NVM_DIR/nvm.sh" && \
    . "$NVM_DIR/bash_completion" && \
    nvm install stable && \
    nvm use stable && \
    nvm alias default stable && \
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc

ENV PATH="$NVM_DIR/versions/node/$(ls $NVM_DIR/versions/node)/bin/:$PATH"

# ----------------------
# Instala Python3 e pip3
# ----------------------
RUN apt-get install -y python3 python3-pip

# ----------------------
# Instala Rust via rustup
# ----------------------
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    echo 'source "$HOME/.cargo/env"' >> ~/.bashrc

ENV PATH="/root/.cargo/bin:$PATH"

# ----------------------
# Instala PHP + Extensões
# ----------------------
RUN apt-get install -y php php-cli php-common php-mbstring php-xml php-curl php-mysql php-zip php-bcmath php-intl \
    php-soap php-xmlrpc php-gd php-opcache php-readline php-dev php-pear php-pgsql php-redis php-imagick \
    php-sqlite3 php-xdebug

# Ativa o Xdebug
RUN find /usr/lib/php -name xdebug.so | while read xdebug; do \
    version=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;'); \
    echo "zend_extension=${xdebug}" > /etc/php/${version}/cli/conf.d/20-xdebug.ini; \
done

# ----------------------
# Instala Docker CLI
# ----------------------
RUN apt-get install -y docker.io

# ----------------------
# Limpeza
# ----------------------
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Volta para o usuário padrão do code-server
USER coder