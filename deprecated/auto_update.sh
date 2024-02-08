#!/bin/bash

update_script_name=update.sh

current_path=$(dirname "$(readlink -f "$0")")
update_script_name="$current_path/$update_script_name"
echo "Restart script name: $update_script_name"

chmod +x "$update_script_name"

# 每天凌晨 4 点执行一次 update 脚本
cron_job="0 4 * * * /bin/bash $update_script_name >> /tmp/pal-update.log 2>&1"
if ! crontab -l | grep -Fq "$update_script_name"; then
    (crontab -l 2>/dev/null; echo "$cron_job") | crontab -
fi