FROM alpine:3.6

# Certificates needed for https requests, to avoid
# "x509: failed to load system roots and no roots provided" error.
# Also installs Gor and its dependency libpcap. Need to build libpcap 1.7.4
# Gor also needs libc6 version 2.14 or greater which is in the wheezy testing repo
RUN apk add --update --no-cache --virtual .build-dependencies ca-certificates curl alpine-sdk linux-headers flex bison && \
  curl -L https://github.com/Clever/gor/releases/download/v0.13.5/libpcap-1.7.4.tar.gz | tar xz && cd libpcap-1.7.4 && ./configure && make install && cd .. && rm -rf libpcap-1.7.4 && \
  curl -L https://github.com/Clever/gor/releases/download/v0.13.1/gor_0.13.1_x64.tar.gz | tar xz -C /usr/local/bin/ && chmod +x /usr/local/bin/gor && \
  apk add --no-cache libc6-compat && \
  apk del .build-dependencies
