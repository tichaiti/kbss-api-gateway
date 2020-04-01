#!/usr/bin/env sh

GLOO_URL=${GLOO_URL:-gloo:9977}
PORT=${PORT:-8080}
CONSUL_URL=${CONSUL_URL:-consul:8500}
VAULT_URL=${VAULT_URL:-http://vault:8200}

case ${GLOO_URL} in
  (*:*) GLOO_ADDRESS=${GLOO_URL%:*} GLOO_PORT=${1##*:};;
  (*)   GLOO_ADDRESS=${GLOO_URL}    GLOO_PORT=80;;
esac

sed -i s/GLOO_ADDRESS/${GLOO_ADDRESS}/g config/envoy.yaml
sed -i s/GLOO_PORT/${GLOO_PORT}/g config/envoy.yaml
sed -i s/PORT/${PORT}/g config/envoy.yaml

sed -i s/PORT/${PORT}/g data/gateways/gloo-system/gw-proxy.yaml
sed -i s/CONSUL_URL/${CONSUL_URL}/g data/gloo-system/default.yaml
sed -i "s|VAULT_URL|${VAULT_URL}|g" data/gloo-system/default.yaml

/usr/local/bin/gloo --dir=/data/ &

/usr/local/bin/gateway --dir=/data/ &

/usr/bin/dumb-init -- /usr/local/bin/envoy -c /config/envoy.yaml --disable-hot-restart