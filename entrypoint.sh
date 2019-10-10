#!/bin/sh

if [ -z "$OUT" ]; then
    echo '$OUT not supplied.'
    exit 1
fi

if [ ! -z "$VERBOSE" ]; then
    lsif-go --noContents --out temp.lsif -v --debug
    lsif-gomod --in temp.lsif --out "$OUT"
    rm temp.lsif
else
    lsif-go --noContents --stdout | lsif-gomod --stdin --out "$OUT"
fi
