#!/usr/bin/env sh

GLOO_URL=${GLOO_URL:-gloo:9977}
VAULT_URL=${VAULT_URL:-http://vault:8200}

case ${GLOO_URL} in
  (*:*) GLOO_ADDRESS=${GLOO_URL%:*} GLOO_PORT=${1##*:};;
  (*)   GLOO_ADDRESS=${GLOO_URL}    GLOO_PORT=80;;
esac

sed -i s/GLOO_ADDRESS/${GLOO_ADDRESS}/g config/envoy.yaml
sed -i s/GLOO_PORT/${GLOO_PORT}/g config/envoy.yaml
sed -i s/PORT/${PORT}/g config/envoy.yaml

/usr/bin/dumb-init -- /usr/local/bin/envoy -c /config/envoy.yaml --disable-hot-restart