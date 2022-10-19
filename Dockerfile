FROM caddy:2-builder AS builder

RUN xcaddy build \
  --with github.com/hslatman/caddy-crowdsec-bouncer/http \
  --with github.com/darkweak/souin/plugins/caddy

FROM caddy:2
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
