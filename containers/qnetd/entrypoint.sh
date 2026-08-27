#!/bin/bash
set -e

echo "=========================================="
echo " Proxmox Corosync QNetD"
echo "=========================================="

mkdir -p /run/sshd
mkdir -p /etc/corosync/qnetd
mkdir -p /root/.ssh

# Generate SSH host keys if they don't exist
ssh-keygen -A

# Optional root password
if [ -n "${ROOT_PASSWORD}" ]; then
    echo "root:${ROOT_PASSWORD}" | chpasswd
else
    passwd -d root >/dev/null 2>&1 || true
fi

# Start SSH
/usr/sbin/sshd

echo "Starting corosync-qnetd..."

# Run qnetd in foreground, but let Docker supervise it
exec corosync-qnetd -4 -f
