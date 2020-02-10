#!/bin/sh
function module {
    printf '{'
    inside=0
    for arg in "$@"; do
        [ $inside -eq 1 ] && printf ','
        inside=1
        echo -n "$arg" | sed 's/^\([^=]*\)=\(.*\)$/"\1":"\2"/'
    done
    echo '}'
}
function separator {
    echo -n ','
}
echo '{ "version": 1 } [ []'
while :; do
    printf ',['
    module\
        name="wifi"\
        full_text="WiFi:$(nmcli device status | grep ' connected' | awk '{print $4}')"\
        color="#2e2ed9"
    separator
    module\
        name="sound"\
        full_text="Vol: $(amixer sget 'Master' | grep -e '%' | grep Left | sed 's/[^[]*\[\([0-9]\+%\)\].*/\1/g')"\
        color="#d92e92"
    separator
    module\
        name="time"\
        full_text="$(date --rfc-3339=seconds | sed -e 's/-/\//g' -e 's/+\(.*\)//g')"\
        color="#92d92e"
    separator
    module\
        name=battery\
        full_text="Bat: $(acpi | sed 's/.* \([0-9]\+%\).*/\1/g')"\
        color=$(case $(acpi|tr -d ','|awk '{print $3}') in 'Charging') echo '#20e0a0' ;; 'Discharging') echo '#ff9020' ;; 'Unknown') echo '#d9d92e' ;; esac)
    echo ']'
    sleep 1
done
