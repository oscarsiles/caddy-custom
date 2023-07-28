FROM --platform=$TARGETPLATFORM caddy:2.7-builder AS builder

RUN xcaddy build \
  --with github.com/hslatman/caddy-crowdsec-bouncer/http \
  --with github.com/WeidiDeng/caddy-cloudflare-ip \
  --with github.com/caddy-dns/cloudflare \
  --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
  --with github.com/fvbommel/caddy-dns-ip-range \
  --with github.com/fvbommel/caddy-combine-ip-ranges \
  --with github.com/pteich/caddy-tlsconsul

FROM --platform=$TARGETPLATFORM caddy:2.7
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

HEALTHCHECK --interval=30s --timeout=3s --start-period=1m CMD wget -q --tries=1 --spider http://localhost:2019/metrics || exit 1
