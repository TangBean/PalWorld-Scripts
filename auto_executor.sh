#!/bin/bash

script_name=""
period=""

for arg in "$@"
do
    case $arg in
        --script_name=*)
        script_name="${arg#*=}"
        ;;
        --period=*)
        period="${arg#*=}"
        ;;
    esac
done

if [ -z "$script_name" ] || [ -z "$period" ]; then
    echo -e "\033[31m[ERROR] --script_name and --period cannot be none\033[0m"
    exit 1
fi

script_name="$script_name.sh"
log_file="/tmp/pal-$script_name.log"

current_path=$(dirname "$(readlink -f "$0")")
script_name="$current_path/$script_name"
echo "Restart script name: $script_name, Period: $period"

chmod +x "$script_name"

cron_job="$period /bin/bash $script_name >> $log_file 2>&1"
#echo "$cron_job"
if ! crontab -l | grep -Fq "$script_name"; then
    (crontab -l 2>/dev/null; echo "$cron_job") | crontab -
fi
