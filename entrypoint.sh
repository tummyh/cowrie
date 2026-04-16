#!/bin/bash
set -e

# Start Promtail in background
echo "Starting Promtail..."
promtail -config.file=/etc/promtail.yml &

# Start Cowrie in foreground
echo "Starting Cowrie..."
exec cowrie start -n
