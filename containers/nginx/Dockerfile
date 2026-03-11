FROM nginx:alpine

ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

LABEL org.opencontainers.image.created=$BUILD_DATE \
org.opencontainers.image.version=$VERSION \
org.opencontainers.image.revision=$VCS_REF \
org.opencontainers.image.title="Nginx Container" \
org.opencontainers.image.description="Nginx web server container" \
org.opencontainers.image.licenses="MIT"

EXPOSE 80
