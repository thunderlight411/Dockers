# Use the latest version of Alpine as a base of the container.
FROM alpine:latest

# Install required packages
RUN apk add --no-cache \
    bash \
    lftp \
    tzdata \
    ca-certificates

# Set working directory
WORKDIR /scripts

# Copy scripts
COPY scripts/download.sh .
COPY scripts/crontab /etc/crontabs/root

# Make script executable
RUN chmod +x /scripts/download.sh

# Ensure log directory exists
RUN mkdir -p /var/log

# Start cron in foreground
CMD ["crond", "-f", "-l", "8"]