#!/bin/sh

: ${OUT:?output file not specified}
: ${PROJECT_ROOT:?project root not specified}
: ${MODULE_ROOT:?module root not specified}
: ${ADDITIONAL_ARGS=''}

OUTPUT_DIR="$(cd "$(dirname "$OUT")" && pwd)"
ABS_OUT="${OUTPUT_DIR}/$(basename "$OUT")"
cd "${PROJECT_ROOT}"
lsif-go --output "$ABS_OUT" --module-root "$MODULE_ROOT" $ADDITIONAL_ARGS
cd -
