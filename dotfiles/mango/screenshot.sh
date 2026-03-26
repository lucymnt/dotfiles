#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures/Screenshots}"
MODE="${1:-region}"
mkdir -p "$PICTURES_DIR"

case "${MODE}" in
region)
  GEOM=$(slurp -d) || exit 0
  grim -g "$GEOM" -
  ;;
window)
  GEOM=$(slurp -d) || exit 0
  grim -g "$GEOM" -
  ;;
monitor-focused)
  OUTPUT=$(slurp -f "%o" -p) || exit 0
  grim -o "$OUTPUT" -
  ;;
monitor-all)
  grim -
  ;;
*)
  echo "Usage: $0 {region|window|monitor-focused|monitor-all}" >&2
  exit 1
  ;;
esac | satty --filename - --output-filename "${PICTURES_DIR}/screenshot-%+.png"

