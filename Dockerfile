FROM golang:1.13.1-buster as builder

ENV INDEXER_COMMIT=d3622d5d3f8aeb9e7fe5975b8922177b58343591

WORKDIR /build
RUN git clone https://github.com/sourcegraph/lsif-go.git . && \
    git checkout -q "${INDEXER_COMMIT}" && \
    go install ./cmd/lsif-go

FROM golang:1.13.1-buster

LABEL version="0.2.0"
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
