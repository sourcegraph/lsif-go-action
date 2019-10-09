#!/bin/sh

if [ ! -z "$VERBOSE" ]; then
    lsif-go --noContents --out temp.lsif -v
    lsif-gomod --in temp.lsif --out data.lsif
    rm temp.lsif
else
    lsif-go --noContents --stdout | lsif-gomod --stdin --out data.lsif
fi
