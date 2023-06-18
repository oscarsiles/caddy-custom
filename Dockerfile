FROM caddy:2.7-builder-alpine AS builder

RUN xcaddy build \
  --with github.com/abiosoft/caddy-json-schema \
  --with github.com/mholt/caddy-l4 \
  --with github.com/hslatman/caddy-crowdsec-bouncer/http \
  --with github.com/WeidiDeng/caddy-cloudflare-ip \
  --with github.com/caddy-dns/cloudflare \
  --with github.com/lucaslorentz/caddy-docker-proxy/v2

FROM caddy:2.7-alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]
HEALTHCHECK --interval=30s --timeout=3s --start-period=1m CMD wget -q --tries=1 --spider http://localhost:2019/metrics || exit 1
