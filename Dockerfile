FROM golang:1.24-bullseye AS builder

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  upx-ucl

WORKDIR /build

COPY . .

# Build
RUN go mod download && go mod tidy
RUN CGO_ENABLED=0 go build \
  -ldflags='-w -s -extldflags "-static"' \
  -o ./bin/blast blast.go \
  && upx-ucl --best --ultra-brute ./bin/blast

###############################################################################
# final stage
FROM scratch

ARG APPLICATION="blast"
ARG DESCRIPTION="🚀 Blast: A powerful, lightweight HTTP load generator for stress testing and benchmarking web applications with ease."
ARG PACKAGE="trinhminhtriet/blast"

LABEL org.opencontainers.image.ref.name="${PACKAGE}" \
  org.opencontainers.image.authors="Triet Trinh <contact@trinhminhtriet.com>" \
  org.opencontainers.image.documentation="https://github.com/${PACKAGE}/README.md" \
  org.opencontainers.image.description="${DESCRIPTION}" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.source="https://github.com/${PACKAGE}"

COPY --from=builder /build/bin/blast /bin/
WORKDIR /workdir
ENTRYPOINT ["/bin/blast"]
