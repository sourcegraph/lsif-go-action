FROM golang:1.13.1-buster as builder

ENV INDEXER_COMMIT=f8617a7afda6b9730dba368c7449eee38ff68722 # v1.7.0

WORKDIR /build
RUN git clone https://github.com/sourcegraph/lsif-go.git . && \
    git checkout -q "${INDEXER_COMMIT}" && \
    go install ./cmd/lsif-go

FROM golang:1.13.1-buster

LABEL version="0.3.0"
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
