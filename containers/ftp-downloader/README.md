# FTP Downloader Docker Container

A lightweight Docker container that downloads files from an FTP server on a scheduled basis.
The container uses **lftp** for reliable FTP mirroring and **cron** to execute the download task daily.

This project is designed to run easily in environments such as **Portainer**, **Docker Compose**, or a simple **docker run** command.

---

# Features

* Automated FTP downloads using `lftp`
* Scheduled execution via `cron`
* Lightweight Alpine Linux base image
* Environment variable configuration
* Compatible with **Docker**, **Docker Compose**, and **Portainer Stacks**

---

# Environment Variables

| Variable   | Required | Description                      | Example         |
| ---------- | -------- | -------------------------------- | --------------- |
| FTP_HOST   | Yes      | FTP server hostname or IP        | ftp.example.com |
| FTP_USER   | Yes      | FTP username                     | backup-user     |
| FTP_PASS   | Yes      | FTP password                     | secretpassword  |
| REMOTE_DIR | No       | Remote FTP directory to mirror   | /backups        |
| LOCAL_DIR  | No       | Local directory inside container | /downloads      |

Default local download directory:

```
/downloads
```

---

# Docker Run Example

Example of running the container using a standard Docker command.

```bash
docker run -d \
  --name ftp-downloader \
  -e FTP_HOST=ftp.example.com \
  -e FTP_USER=backup-user \
  -e FTP_PASS=secretpassword \
  -e REMOTE_DIR=/backups \
  -v /data/ftp:/downloads \
  --restart unless-stopped \
  ghcr.io/YOUR_GITHUB_USERNAME/ftp-downloader:latest
```

Explanation:

* `/data/ftp` → local directory where files will be stored
* `/downloads` → directory inside the container
* `--restart unless-stopped` → ensures container restarts automatically

---

# Docker Stack / Portainer Example

Example stack configuration for **Portainer** or **Docker Swarm**.

```yaml
version: "3.8"

services:

  ftp-downloader:
    image: ghcr.io/YOUR_GITHUB_USERNAME/ftp-downloader:latest
    container_name: ftp-downloader

    environment:
      FTP_HOST: ftp.example.com
      FTP_USER: backup-user
      FTP_PASS: secretpassword
      REMOTE_DIR: /backups

    volumes:
      - /data/ftp:/downloads

    restart: unless-stopped
```

Deploy in Portainer:

1. Go to **Stacks**
2. Click **Add Stack**
3. Paste the configuration
4. Deploy the stack

---

# How It Works

1. The container starts.
2. `cron` runs inside the container.
3. At the scheduled time, the script executes:

```
/scripts/download.sh
```

4. The script runs an `lftp mirror` command that synchronizes files from the FTP server to the local directory.

Example command executed internally:

```
lftp mirror --verbose --continue --parallel=2 /remote /downloads
```

This ensures:

* interrupted downloads resume
* only new or changed files are downloaded
* downloads run efficiently

---

# Logs

Logs can be viewed using Docker:

```
docker logs ftp-downloader
```

Or via Portainer container logs.

---

# License

MIT License
