# Reuse the proven production image so rebuilding this UI-only change does not
# depend on Alpine package repositories or replace the Dashboard runtime.
FROM ghcr.io/xxbb678/argo-nezha-v1:latest

COPY main.conf /etc/nginx/conf.d/main.conf
COPY frontend/dist/ /usr/share/nginx/html/
COPY docker_backup.sh /backup.sh
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /backup.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
