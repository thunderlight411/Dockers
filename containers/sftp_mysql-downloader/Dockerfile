FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="backup-runner"
LABEL org.opencontainers.image.licenses="MIT"

ENV DEBIAN_FRONTEND=noninteractive

# Base tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    gnupg \
    openssh-client \
    sshpass \
    unzip \
    zip \
    bash \
    && rm -rf /var/lib/apt/lists/*

# MySQL official repo (zonder interactive installer)
RUN mkdir -p /etc/apt/keyrings && \
    wget -qO /etc/apt/keyrings/mysql.gpg https://repo.mysql.com/RPM-GPG-KEY-mysql-2022 && \
    echo "deb [signed-by=/etc/apt/keyrings/mysql.gpg] http://repo.mysql.com/apt/debian/ bookworm mysql-8.0" > /etc/apt/sources.list.d/mysql.list

# Install echte MySQL client
RUN apt-get update && apt-get install -y --no-install-recommends \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

CMD ["bash"]
