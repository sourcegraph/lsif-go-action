#!/bin/sh

: ${OUT:?output file not specified}
: ${PROJECT_ROOT:?project root not specified}
: ${MODULE_ROOT:?module root not specified}

OUTPUT_DIR="$(cd "$(dirname "$OUT")" && pwd)"
ABS_OUT="${OUTPUT_DIR}/$(basename "$OUT")"
cd "${PROJECT_ROOT}"
lsif-go --out "$ABS_OUT" --moduleRoot "$MODULE_ROOT"
cd -
