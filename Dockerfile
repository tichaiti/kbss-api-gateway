FROM quay.io/solo-io/gloo:1.3.7

FROM quay.io/solo-io/gateway:1.3.7

FROM quay.io/solo-io/gloo-envoy-wrapper:1.3.7
COPY --from=0 /usr/local/bin/gloo /usr/local/bin/
COPY --from=1 /usr/local/bin/gateway /usr/local/bin/
WORKDIR /
COPY ./data /data
COPY envoy-config.yaml /config/envoy.yaml
COPY start-gloo-gateway-proxy.sh start.sh
RUN chmod +x start.sh
ENTRYPOINT []
CMD ./start.sh
