# QNetD Container

A Debian Trixie-based Corosync QNetD server with SSH access for administering
the persistent QNetD certificate state.

## Build

```bash
./scripts/build-local.sh qnetd
```

## Docker Compose

From this directory, configure `ROOT_PASSWORD` in `docker-compose.yml` and run:

```bash
docker compose up -d --build
```

The Compose configuration publishes QNetD on TCP 5403 and SSH on host TCP 2222,
and persists QNetD and SSH data under `./data`.

## Run

```bash
docker run -d \
  --name qnetd \
  -p 22:22 \
  -p 5403:5403 \
  -v qnetd-state:/etc/corosync/qnetd \
  -v "$HOME/.ssh":/root/.ssh:ro \
  -e ROOT_PASSWORD="change-me" \
  local/qnetd
```

Keep `/etc/corosync/qnetd` in persistent storage so QNetD state survives
container recreation.

The image permits root SSH login using an authorized key mounted at
`/root/.ssh/authorized_keys`. Set `ROOT_PASSWORD` to configure root password
authentication; when it is unset, the entrypoint removes the root password.
