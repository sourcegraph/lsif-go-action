#!/bin/sh

if [ -z "$OUT" ]; then
    echo 'file not supplied.'
    exit 1
fi

lsif-go --projectRoot "${PROJECT_ROOT}" --out "$OUT"
