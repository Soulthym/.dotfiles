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
        name="free_memory"\
        full_text="$(free -w | awk 'BEGIN{i=0;s=""}{i=i+1;if (i>1) s=s$4"/"$2"*100,"}END{print s}' |sed -e 's/,/\n/g'|bc -l |sed -e 's/\([0-9]\+\)\..*/\1%/' |awk 'BEGIN{i=0}{if (i==0) printf "Mem: R:"$0"|C:"; else printf $0; i=i+1}')"\
        color="#d9922e"
    separator
    module\
        name="SSD Space"\
        full_text="$(df -h | awk '/mapper/{print $6 ": " $5 "|"}' | tr -d '\n' | sed 's/|$//')"\
        color="#d92e92"
    separator
    module\
        name="wifi"\
        full_text="WiFi:$(nmcli device status | grep ' connected' | awk '{print $4}')"\
        color="#2e2ed9"
    separator
    module\
        name="sound"\
        full_text="Vol: $(read -r volume status<<<$(amixer sget Master|grep Left | awk -F"[][]" '/%/{print gensub(/%/,"","g",$2) "\t" $4}');echo $volume$(case $status in on) printf "%%";; off) printf "M";; esac))"\
        color="#d92e92"
    separator
    module\
        name="time"\
        full_text="$(date --rfc-3339=seconds | sed -e 's/-/\//g' -e 's/+\(.*\)//g')"\
        color="#92d92e"
    separator
    module\
        name="battery"\
        full_text="Bat: $(acpi | sed 's/.* \([0-9]\+%\).*/\1/g')"\
        color=$(case $(acpi|tr -d ','|awk '{print $3}') in 'Charging') echo '#20e0a0' ;; 'Discharging') echo '#ff9020' ;; 'Unknown') echo '#d9d92e' ;; esac)
    echo ']'
    sleep 1
done
