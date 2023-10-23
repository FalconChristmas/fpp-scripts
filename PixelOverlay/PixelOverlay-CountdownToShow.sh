#!/usr/bin/bash
#############################################################################
# Settings
HOST="localhost" # Host/ip of the FPP instance with the matrix
MODEL_NAME="Matrix" # PixelOverlay Model Name
FONT_COLOR="#FF0000" # Text Color (also names like 'red', 'blue', etc.)
FONT_NAME="Helvetica" # Font Name
FONT_SIZE=10 # Font size
TEXT_POS="R2L" # Position: 'Center', 'L2R', 'R2L', 'T2B', 'B2T'
PIXELS_PER_SEC=5 # Pixels Per Second
ANTI_ALIAS=false # Anti-Alias the text
#############################################################################

put_json() {
    curl -H "Content-Type: application/json" -X PUT -d "${2}" "${1}"
    echo ""
}

SETUP_DONE=0

while true; do
    FPP_STATUS=$(fpp -s)

    # Check that we got something meaningful.
    if [ -z "${FPP_STATUS}" ]; then
        echo "Error with status value" >&2
        exit 1
    fi

    PLAYING_STATUS=$(cut -d',' -f2 <<< "${FPP_STATUS}")

    # Check if player is idle
    if [ "${PLAYING_STATUS}" != "0" ]; then
        echo "Not running count-down because player is already running."
        exit 1
    fi

    NEXT_SHOW_TIME=$((cut -d',' -f5 <<< "${FPP_STATUS}") | cut -d'-' -f1 | sed "s/@ //")

    # Check there is something scheduled in the future.
    if [ -z "${NEXT_SHOW_TIME}" ]; then
        echo "ERROR: There is nothing scheduled / nothing to countdown to."
        exit 1
    fi

    SHOW_TIME=$(date +%s --date="${NEXT_SHOW_TIME}")

    if [ "${SHOW_TIME}" -le $(date +%s) ]; then
        break
    fi

    if [ "${SETUP_DONE}" == "0" ]; then
        # Clear the model
        curl "http://${HOST}/api/overlays/model/${MODEL_NAME}/clear"
        echo ""

        # Enable the block (pass 2 for transparent mode, or 3 for transparent RGB)
        put_json "http://${HOST}/api/overlays/model/${MODEL_NAME}/state" "{\"State\":1}"

        SETUP_DONE=1
    fi

    NOW="$(date +%s)"
    TIME_REMAINING="$(( ${SHOW_TIME} - ${NOW} ))"
    DAYS="$((${TIME_REMAINING} / 86400))"
    TIME_REMAINING="$((${TIME_REMAINING} - $((${DAYS} * 86400)) ))"
    HOURS="$((${TIME_REMAINING} / 3600))"
    TIME_REMAINING="$((${TIME_REMAINING} - $((${HOURS} * 3600)) ))"
    COUNTDOWN_STR=""
    if [ "${DAYS}" != "0" ]; then
        COUNTDOWN_STR+="${DAYS}d "
        COUNTDOWN_STR+="${HOURS}:"
    elif [ "${HOURS}" != "0" ]; then
        COUNTDOWN_STR+="${HOURS}:"
    fi
    COUNTDOWN_STR+=$(date -u -d "@${TIME_REMAINING}" +%M:%S)
    JSON_DATA="{\"Message\":\"${COUNTDOWN_STR}\",
                      \"Color\":\"${FONT_COLOR}\",
                      \"Font\":\"${FONT_NAME}\",
                      \"FontSize\":${FONT_SIZE},
                      \"AntiAlias\":${ANTI_ALIAS},
                      \"Position\":\"${TEXT_POS}\",
                      \"PixelsPerSecond\":${PIXELS_PER_SEC}}"
    put_json "http://${HOST}/api/overlays/model/${MODEL_NAME}/text" "${JSON_DATA}"
    sleep 1
done

# Clear the model
curl "http://${HOST}/api/overlays/model/${MODEL_NAME}/clear"
echo ""

# Disable the block
put_json "http://${HOST}/api/overlays/model/${MODEL_NAME}/state" "{\"State\":0}"
