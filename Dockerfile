FROM golang:1.23 as build

# See https://stackoverflow.com/a/55757473/12429735
ENV USER=appuser
ENV UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    "${USER}"

RUN apt-get update && apt-get install -y ca-certificates
RUN go get github.com/trinhminhtriet/blast

# Build
WORKDIR /go/src/github.com/trinhminhtriet/blast
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /go/bin/blast blast.go

###############################################################################
# final stage
FROM scratch
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /etc/group /etc/group
USER appuser:appuser

ARG APPLICATION="blast"
ARG DESCRIPTION="🚀 Blast: A powerful, lightweight HTTP load generator for stress testing and benchmarking web applications with ease."
ARG PACKAGE="trinhminhtriet/blast"

LABEL org.opencontainers.image.ref.name="${PACKAGE}" \
    org.opencontainers.image.authors="Triet Trinh <contact@trinhminhtriet.com>" \
    org.opencontainers.image.documentation="https://github.com/${PACKAGE}/README.md" \
    org.opencontainers.image.description="${DESCRIPTION}" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/${PACKAGE}"

COPY --from=build /go/bin/${APPLICATION} /blast
ENTRYPOINT ["/blast"]
