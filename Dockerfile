FROM golang:1.13.1-buster as builder

# The commit at which to build lsif-go
ENV INDEXER_COMMIT=d933636638aac3965d75d1ea357c60aefd7527f7
ENV CLONE_URL="https://github.com/sourcegraph/lsif-go.git"

WORKDIR /build
RUN git clone "${CLONE_URL}" . && \
    git checkout -q "${INDEXER_COMMIT}" && \
    go install ./cmd/lsif-go

FROM golang:1.13.1-buster

LABEL version="0.1.0"
LABEL repository="http://github.com/sourcegraph/lsif-go-action"
LABEL homepage="http://github.com/sourcegraph/lsif-go-action"
LABEL maintainer="Sourcegraph Support <support@sourcegraph.com>"

LABEL "com.github.actions.name"="Sourcegraph Go LSIF Indexer"
LABEL "com.github.actions.description"="Generate LSIF data from Go source code"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="purple"

COPY --from=builder /go/bin/lsif-go /go/bin/lsif-go
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
