FROM caddy:2.6-builder-alpine AS builder

RUN xcaddy build \
  --with github.com/hslatman/caddy-crowdsec-bouncer/http \
  --with github.com/WeidiDeng/caddy-cloudflare-ip

FROM caddy:2.6-alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
