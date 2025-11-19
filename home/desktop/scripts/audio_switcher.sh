#!/usr/bin/env bash

notify() {
    command -v notify-send &> /dev/null && notify-send "$@"
}

# Build sink list with ID|Display format
sink_list=$(wpctl status | awk '/Sinks:/,/Sources:/' | grep -E "^\s+│\s+\*?\s*[0-9]+\." | sed -E 's/^\s+│\s+//; s/\s+\[vol:.*\]$//' | while read -r line; do
    # Check for active marker
    if echo "$line" | grep -q "^\*"; then
        # Remove asterisk and ID
        sink_id=$(echo "$line" | grep -oP '\d+' | head -1)
        raw_name=$(echo "$line" | sed -E 's/^\*\s*[0-9]+\.\s+//')

        # Clean up the name
        clean_name=$(echo "$raw_name" | sed -E '
            s/Family 17h\/19h\/1ah HD Audio Controller/Internal Audio/;
            s/Renoir\/Cezanne HDMI\/DP Audio Controller//;
            s/HDMI \/ DisplayPort ([0-9]+) Output/HDMI \1/;
            s/Analog Stereo/Stereo/;
            s/USB Audio/USB/;
            s/Speaker$//;
        ' | xargs)

        echo "$sink_id|[*] $clean_name"
    else
        # Remove ID
        sink_id=$(echo "$line" | grep -oP '^\d+')
        raw_name=$(echo "$line" | sed -E 's/^[0-9]+\.\s+//')

        # Clean up the name
        clean_name=$(echo "$raw_name" | sed -E '
            s/Family 17h\/19h\/1ah HD Audio Controller/Internal Audio/;
            s/Renoir\/Cezanne HDMI\/DP Audio Controller//;
            s/HDMI \/ DisplayPort ([0-9]+) Output/HDMI \1/;
            s/Analog Stereo/Stereo/;
            s/USB Audio/USB/;
            s/Speaker$//;
        ' | xargs)

        echo "$sink_id|    $clean_name"
    fi
done)

[ -z "$sink_list" ] && { notify "Audio Switcher" "No sinks found"; exit 1; }

# Show only display names in fuzzel
selected=$(echo "$sink_list" | cut -d'|' -f2 | fuzzel --dmenu --prompt "Audio: " --width 35 --line-height 18 --inner-pad 8)

[ -z "$selected" ] && exit 0

# Get the ID from the original list
sink_id=$(echo "$sink_list" | grep -F "|$selected" | cut -d'|' -f1)

if [ -n "$sink_id" ]; then
    wpctl set-default "$sink_id"

    pactl list short sink-inputs | awk '{print $1}' | while read -r input_id; do
        pactl move-sink-input "$input_id" "$sink_id" 2>/dev/null
    done

    clean=$(echo "$selected" | sed -E 's/^\[\*\]\s*//; s/^\s+//')
    notify "Audio Output" "$clean"
else
    notify "Audio Switcher" "Failed to switch"
    exit 1
fi
