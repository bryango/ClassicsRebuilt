#!/bin/bash
# build script for witten's lectures

function log { echo "###" "$@"; }

[[ -n $1 ]] \
    && DIR=$1 \
    || DIR=$(dirname "$(readlink -f "$0")")

log "$DIR"

FLAGS="-synctex=15 -interaction=batchmode -output-format=pdf"
FILES=$(
    find ../www.math.ias.edu/QFT/spring \
        -name "*witten*.tex"
)

log "Files:"
echo "$FILES"

for file in $FILES; do
    log "Compiling \`$file\` ..."

    pathname=$(dirname "$file")
    filename=$(basename "$file")

    cd "$pathname" || exit 1

    { # forked

        if grep -E "(witten7)|(witten8-II)|(witten2-I)" <<< "$filename"; then
            tex_program=pdflatex
        else
            tex_program=pdftex
        fi

        # shellcheck disable=2086
        "$tex_program" $FLAGS "$filename" # 1>/dev/null

        log "Check & release PDF:"
        pdf="$(basename "$filename" .tex).pdf"
        if ls "$pdf"; then

            # # shellcheck disable=2015
            # [[ $USER == bryan ]] \
            #     && cp -a -v -f "$pdf" "$target/." \
            #     || mv -v -f "$pdf" "$target/."

            ln -sf "$pathname/$pdf" "$DIR"
        fi
    } # &

    cd "$DIR" || exit 1
done

wait
ls -alF "$DIR"
