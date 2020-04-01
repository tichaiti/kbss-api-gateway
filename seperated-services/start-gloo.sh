#!/usr/bin/env sh

CONSUL_URL=${CONSUL_URL:-consul:8500}
VAULT_URL=${VAULT_URL:-http://vault:8200}

sed -i s/CONSUL_URL/${CONSUL_URL}/g data/gloo-system/default.yaml
sed -i "s|VAULT_URL|${VAULT_URL}|g" data/gloo-system/default.yaml

/usr/local/bin/gloo --dir=/data/
