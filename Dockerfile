FROM golang:1.13.1-alpine3.10 as builder

# The commit at which to build lsif-go and lsif-gomod
ENV INDEXER_COMMIT=31f713911725c7b0d3871251f53678f217162c3d
ENV CLONE_URL="https://github.com/sourcegraph/lsif-go.git"

WORKDIR /build
RUN apk add --no-cache git=2.22.0-r0 && \
    git clone "${CLONE_URL}" . && \
    go install ./cmd/lsif-go && \
    go install ./cmd/lsif-gomod

FROM golang:1.13.1-alpine3.10

LABEL version="0.1.0"
LABEL repository="http://github.com/sourcegraph/lsif-go-action"
LABEL homepage="http://github.com/sourcegraph/lsif-go-action"
LABEL maintainer="Sourcegraph Support <support@sourcegraph.com>"

LABEL "com.github.actions.name"="Sourcegraph Go LSIF Indexer"
LABEL "com.github.actions.description"="Generate LSIF data from Go source code"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="purple"

COPY --from=builder /go/bin/lsif-go /go/bin/lsif-go
COPY --from=builder /go/bin/lsif-gomod /go/bin/lsif-gomod
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
