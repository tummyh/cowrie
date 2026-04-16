FROM cowrie/cowrie:latest

# Install Promtail
RUN apt-get update && \
    apt-get install -y wget && \
    wget -qO /usr/local/bin/promtail https://github.com/grafana/loki/releases/download/v2.9.3/promtail-linux-amd64.zip && \
    unzip /usr/local/bin/promtail -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/promtail && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy configs
COPY promtail.yml /etc/promtail.yml
COPY entrypoint.sh /entrypoint.sh
COPY cowrie.cfg.dist /cowrie/cowrie.cfg.dist

RUN chmod +x /entrypoint.sh

# Expose SSH ports
EXPOSE 2222 2223

ENTRYPOINT ["/entrypoint.sh"]
