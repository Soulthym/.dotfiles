#!/bin/sh
function bar_parser {
    cat /home/$USER/.config/i3/bar \
        | /bin/awk '
    BEGIN {
        printf "echo \""
        inside=0
        prev_indent=0
        printf ",["
    }
    {
        line=$0
        indent=length(gensub(\
                /^(\s*)(.*)/,
                "\\1",
                "g",
                line))
        if (indent == 0 && inside == 1) {
            printf "},\n"
        }
        inside = 1
        if ((indent > 0) && (prev_indent > 0)) {
            printf ","
        }
        if (indent == 0) {
            printf "{\\\"name\\\":\\\""$2"\\\","
        } else if (indent > 0) {
            formatted_line=gensub(\
                    /^\s+([^:\s]+)\s*:\s*(.*)$/,
                    "\\\\\"\\1\\\\\":\\\\\"\\2\\\\\"",
                    "g",
                    line)
            printf formatted_line
        }
        prev_indent=indent
    }
    END {
        printf "}"
        printf "]"
        print "\""
    }' | sh
}
echo "{ \"version\": 1 }"
echo '['
echo '[]'
while :;
do
    bar_parser
	sleep 1
done
