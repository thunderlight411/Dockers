FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        corosync-qnetd \
        openssh-server \
        ca-certificates \
        procps \
        iproute2 \
        net-tools \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p \
    /run/sshd \
    /root/.ssh \
    /etc/corosync/qnetd

RUN chown -R coroqnetd:coroqnetd /etc/corosync/qnetd

RUN sed -i \
    -e 's/^#PermitRootLogin.*/PermitRootLogin yes/' \
    -e 's/^#PubkeyAuthentication.*/PubkeyAuthentication yes/' \
    -e 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' \
    /etc/ssh/sshd_config

EXPOSE 22/tcp
EXPOSE 5403/tcp

VOLUME ["/etc/corosync/qnetd", "/root/.ssh"]

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
    CMD corosync-qnetd-tool -s || exit 1

ENTRYPOINT ["/entrypoint.sh"]
