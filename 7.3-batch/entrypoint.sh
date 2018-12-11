#!/bin/sh

# exports env
printenv | awk '{print "export "$1}' > /env.sh

INIT_DIR=/init.d
TMP_CRON=/tmp/crontab

# init crontab
{
    printenv | awk -F"=" '{print $1"=\""$2"\""}'
    echo
} | tee $TMP_CRON

# usage: process_init_file FILENAME
process_init_file() {
    local f="$1"

    case "$f" in
        *.sh)
            echo "$0: running $f"
            . "$f"
            ;;
        *.cron)
            echo "$0: subscribing $f"
            {
                echo "# "$(basename $f)
                cat "$f"
                echo
            } | tee -a $TMP_CRON
            ;;
        *)
            echo "$0: ignoring $f"
            ;;
    esac
    echo
}

find /init.d/ -type f |
while read file
do
    process_init_file "$file"
done

crontab -u root $TMP_CRON

# cron foreground
cron -f -L 15
