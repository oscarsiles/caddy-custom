FROM caddy:2.4.6-builder AS builder

RUN xcaddy build --with github.com/hslatman/caddy-crowdsec-bouncer/crowdsec

FROM caddy:2.4.6
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
