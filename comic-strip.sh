#!/bin/bash

set -eu

function error {
    echo "Usage:"
    echo
    echo "$0 convert <FOLDER>"
    echo "$0 fetch <FOLDER>"
    exit 1
}

function fetch_comic {
    NUMBER="$1"
    if ls "${FOLDER}/index$NUMBER"* > /dev/null 2>&1; then
        return
    fi
    PAGE_EXT="html"
    [[ "$NUMBER" -eq 123 ]] && PAGE_EXT="htm"
    PAGE=$(curl -s "${BASE_URL}/index${NUMBER}.$PAGE_EXT")
    IMAGE=$(echo "$PAGE" | grep 'img.*src.*tir' | sed -E 's/.*src="(\S*)".*/\1/')
    IMAGE_EXT=$(echo "$IMAGE" | grep -o '\..*')
    NAME="index${NUMBER}${IMAGE_EXT}"
    echo "$IMAGE $NAME"
    curl -o "${FOLDER}/${NAME}" "${BASE_URL}/${IMAGE}"
}

BASE_URL="http://malvados.com.br"
COMMAND="${1-}"
FOLDER="${2%/}"

[[ -z "$COMMAND" || -z "$FOLDER" ]] && error

if [[ "$COMMAND" = "convert" ]]; then
    for f in "${FOLDER}/"*; do
        [[ "$f" == *".txt" ]] && continue
        EXT=$(echo "$f" | grep -o '\..*')
        TEXT="${f//$EXT/.txt}"
        [[ -f "$TEXT" ]] && continue
        echo "$TEXT"
        ./ocr "$f" > "$TEXT"
    done
elif [[ "$COMMAND" = "fetch" ]]; then
    INDEX_PAGE=$(curl -s "$BASE_URL")
    LAST_COMIC=$(echo "$INDEX_PAGE" | grep 'src.*index' | grep -o '[0-9]*')
    for i in $(seq 1 "$LAST_COMIC"); do
        fetch_comic "$i"
    done
else
    echo "Command '$COMMAND' not found."
    echo
    error
fi
