# Stage 1: Download Promtail (clean, official image)
FROM grafana/promtail:2.9.3 AS promtail

# Stage 2: Your Cowrie image
FROM cowrie/cowrie:latest

# Copy Promtail from Stage 1 (no download needed!)
COPY --from=promtail /usr/bin/promtail /usr/local/bin/promtail
RUN chmod +x /usr/local/bin/promtail

# Copy your configs
COPY promtail.yml /etc/promtail.yml
COPY entrypoint.sh /entrypoint.sh
COPY cowrie.cfg.dist /cowrie/cowrie.cfg.dist

RUN chmod +x /entrypoint.sh

EXPOSE 2222 2223

ENTRYPOINT ["/entrypoint.sh"]
