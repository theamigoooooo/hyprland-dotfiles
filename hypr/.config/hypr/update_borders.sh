#!/bin/bash

WALJSON="$HOME/.cache/wal/colors.json"
CONFIG="$HOME/.config/hypr/pywal_borders.conf"

if [ ! -f "$WALJSON" ]; then
    echo "❌  Error: Pywal colors.json not found!"
    exit 1
fi

echo "▶️  Picking brightest color for inactive border..."

BRIGHTEST=""
HIGHEST_BRIGHTNESS=-1  # Start with a low value

for COLOR in $(jq -r '.colors | to_entries[] | .value' "$WALJSON" | tr -d '#'); do
    if [ ${#COLOR} -eq 6 ]; then
        R=$((16#${COLOR:0:2}))
        G=$((16#${COLOR:2:2}))
        B=$((16#${COLOR:4:2}))
        LUMA=$(( 299 * R + 587 * G + 114 * B ))
        if [ "$LUMA" -gt "$HIGHEST_BRIGHTNESS" ]; then
            HIGHEST_BRIGHTNESS=$LUMA
            BRIGHTEST=$COLOR
        fi
    fi
done

echo "✅  Brightest Color Found: #$BRIGHTEST (Brightness: $HIGHEST_BRIGHTNESS)"
echo "✅  Brightest Color Found: #$BRIGHTEST (Brightness: $HIGHEST_BRIGHTNESS)"

# Pick darker color (color0) for active border
DARKEST=$(jq -r '.colors.color0' "$WALJSON" | tr -d '#')

# Append alpha
BRIGHTEST="${BRIGHTEST}aa"
DARKEST="${DARKEST}aa"

cat > "$CONFIG" <<EOF
\$border_color = rgba(${BRIGHTEST})
\$inactive_border_color = rgba(${DARKEST})
EOF

echo "✅  Borders updated in $CONFIG"



