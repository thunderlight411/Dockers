FROM alpine:3.20

LABEL org.opencontainers.image.title="backup-runner-minimal"
LABEL org.opencontainers.image.licenses="MIT"

RUN apk add --no-cache \
    bash \
    openssh-client \
    sshpass \
    unzip \
    zip \
    coreutils \
    findutils \
    mysql-client \
    mysql-client-extra

WORKDIR /app

CMD ["bash"]
