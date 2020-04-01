#!/usr/bin/env sh

PORT=${PORT:-8080}
CONSUL_URL=${CONSUL_URL:-consul:8500}
VAULT_URL=${VAULT_URL:-http://vault:8200}

sed -i s/PORT/${PORT}/g data/gateways/gloo-system/gw-proxy.yaml
sed -i s/CONSUL_URL/${CONSUL_URL}/g data/gloo-system/default.yaml
sed -i "s|VAULT_URL|${VAULT_URL}|g" data/gloo-system/default.yaml

/usr/local/bin/gateway --dir=/data/

