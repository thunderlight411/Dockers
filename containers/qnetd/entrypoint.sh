#!/bin/bash
set -e

echo "=========================================="
echo " Proxmox Corosync QNetD"
echo "=========================================="

QNETD_DIR="/etc/corosync/qnetd"
NSSDB_DIR="${QNETD_DIR}/nssdb"

mkdir -p /run/sshd
mkdir -p "${QNETD_DIR}"
mkdir -p /root/.ssh

# --------------------------------------------------
# SSH
# --------------------------------------------------

echo "Configuring SSH..."

ssh-keygen -A

if [ -n "${ROOT_PASSWORD:-}" ]; then
    echo "root:${ROOT_PASSWORD}" | chpasswd
else
    passwd -d root >/dev/null 2>&1 || true
fi

/usr/sbin/sshd

# --------------------------------------------------
# QNetD NSS database
# --------------------------------------------------

echo "Checking QNetD NSS database..."

if [ ! -f "${NSSDB_DIR}/cert9.db" ] || \
   [ ! -f "${NSSDB_DIR}/key4.db" ]; then

    echo "NSS database not found."
    echo "Initializing QNetD NSS database..."

    # NSSDB may be a Docker bind mount.
    # Never remove the mount itself.
    mkdir -p "${NSSDB_DIR}"

    # Remove only existing contents.
    find "${NSSDB_DIR}" -mindepth 1 -maxdepth 1 -exec rm -rf {} +

    corosync-qnetd-certutil -i

    echo "NSS database initialized."
else
    echo "Existing NSS database found."
fi

# --------------------------------------------------
# Permissions
# --------------------------------------------------

chown -R coroqnetd:coroqnetd "${QNETD_DIR}"

echo "Starting corosync-qnetd..."

exec corosync-qnetd -4 -f
