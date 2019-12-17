#!/bin/sh

if [ -z "$OUT" ]; then
    echo '$OUT not supplied.'
    exit 1
fi

if [ ! -z "$VERBOSE" ]; then
    lsif-go --projectRoot "${PROJECT_ROOT}" --noContents --out "$OUT" -v --debug
else
    lsif-go --projectRoot "${PROJECT_ROOT}" --noContents --out "$OUT"
fi
