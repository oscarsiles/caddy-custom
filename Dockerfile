FROM --platform=$TARGETPLATFORM caddy:2.11-builder-alpine AS builder

RUN xcaddy build \
  --with github.com/hslatman/caddy-crowdsec-bouncer/http \
  --with github.com/WeidiDeng/caddy-cloudflare-ip \
  --with github.com/caddy-dns/cloudflare \
  --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
  --with github.com/fvbommel/caddy-dns-ip-range \
  --with github.com/fvbommel/caddy-combine-ip-ranges \
  --with github.com/caddyserver/replace-response \
  --with github.com/caddyserver/cache-handler \
  --with github.com/mholt/caddy-l4

FROM --platform=$TARGETPLATFORM caddy:2.11-alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

HEALTHCHECK --interval=30s --timeout=5s --start-period=1m CMD wget -q --tries=1 --spider http://127.0.0.1:2019/metrics || exit 1
