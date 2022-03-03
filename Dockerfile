FROM golang:1.17.7-buster as builder

# v1.7.6
ENV INDEXER_COMMIT=f45d7a7febb0fe41f89a1baf9c2464504e91662a

WORKDIR /build
RUN git clone https://github.com/sourcegraph/lsif-go.git . && \
    git checkout -q "${INDEXER_COMMIT}" && \
    go install ./cmd/lsif-go

FROM golang:1.17.7-buster

LABEL version="0.4.0"
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
