FROM quay.io/fedora/fedora:38
WORKDIR /workdir
RUN dnf install -y curl
COPY curl.sh .
ENTRYPOINT /workdir/curl.sh