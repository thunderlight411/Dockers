FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="backup-runner"
LABEL org.opencontainers.image.description="Minimal backup runner with MySQL 8 client + SFTP"
LABEL org.opencontainers.image.licenses="MIT"

ENV DEBIAN_FRONTEND=noninteractive

# Base tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    gnupg \
    lsb-release \
    openssh-client \
    sshpass \
    unzip \
    zip \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Add official MySQL APT repo (non-interactive)
RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.29-1_all.deb && \
    dpkg -i mysql-apt-config_0.8.29-1_all.deb >/dev/null 2>&1 || true && \
    rm mysql-apt-config_0.8.29-1_all.deb && \
    apt-get update && \
    apt-get install -y --no-install-recommends mysql-client && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

CMD ["bash"]
