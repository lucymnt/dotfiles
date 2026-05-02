#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures/Screenshots}"
MODE="${1:-region}"

mkdir -p "$PICTURES_DIR"

freeze_and_shot() {
  wayfreeze --hide-cursor &
  FREEZE_PID=$!
  sleep 0.1  # let wayfreeze render

  case "${MODE}" in
    region)
      GEOM=$(slurp -d -b 00000050) || { kill "$FREEZE_PID"; exit 0; }
      grim -g "$GEOM" -
      ;;
    window)
      GEOM=$(slurp -d -b 00000050) || { kill "$FREEZE_PID"; exit 0; }
      grim -g "$GEOM" -
      ;;
    monitor-focused)
      OUTPUT=$(slurp -f "%o" -p -b 00000050) || { kill "$FREEZE_PID"; exit 0; }
      grim -o "$OUTPUT" -
      ;;
    monitor-all)
      grim -
      ;;
    *)
      echo "Usage: $0 {region|window|monitor-focused|monitor-all}" >&2
      kill "$FREEZE_PID"
      exit 1
      ;;
  esac

  kill "$FREEZE_PID"
}

freeze_and_shot | satty --filename - --output-filename "${PICTURES_DIR}/screenshot-%+.png"
