FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="backup-runner-minimal"
LABEL org.opencontainers.image.licenses="MIT"

RUN apt-get update && apt-get install -y \
    mysql-client \
    openssh-client \
    sshpass \
    unzip \
    zip \
    bash \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

CMD ["bash"]
