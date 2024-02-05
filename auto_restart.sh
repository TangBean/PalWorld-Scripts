#!/bin/bash

restart_script_name=restart.sh

current_path=$(dirname "$(readlink -f "$0")")
restart_script_name="$current_path/$restart_script_name"
echo "Restart script name: $restart_script_name"

chmod +x "$restart_script_name"

# 每分钟执行一次 restart 脚本，如果内存利用率过高就重启服务
cron_job="* * * * * /bin/bash $restart_script_name >> /tmp/pal-restart.log 2>&1"
if ! crontab -l | grep -Fq "$restart_script_name"; then
    (crontab -l 2>/dev/null; echo "$cron_job") | crontab -
fi