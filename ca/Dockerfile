FROM alpine:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="Generates Certificate Authority"
ENTRYPOINT ["/bin/ca_entrypoint"]
COPY rootfs /

RUN \
  apk add --no-cache openssl && \
  # Prepare root
  chmod 700 /root/ca/private && \
  cd /root/ca && \
  # Gen root passphrase
  openssl rand -base64 48 > /passphrase.txt && \
  # Gen root key
  openssl genrsa -des3 \
    -passout file:/passphrase.txt \
    -out /ca.key 2048 && \
  chmod 400 /ca.key && \
  # Gen root certificate
  openssl req -x509 -new -nodes -sha256 \
    -config openssl.cnf \
    -days 3650 \
    -passin file:/passphrase.txt \
    -key /ca.key \
    -out /ca.pem \
    -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=LocalDev Inc/OU=Dev/CN=LocalDev" \
    -extensions v3_ca && \
  chmod 444 /ca.pem && \
  # Verify root certificate
  openssl x509 -noout -text -in /ca.pem
