#!/bin/bash
set -e

echo "FTP download started $(date)"

lftp -u "$FTP_USER","$FTP_PASS" "$FTP_HOST" <<EOF
set ftp:ssl-allow no
mirror \
  --verbose \
  --continue \
  --parallel=2 \
  ${REMOTE_DIR:-/} /downloads
quit
EOF

echo "FTP download finished $(date)"