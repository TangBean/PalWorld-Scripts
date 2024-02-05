#!/bin/bash

service_name="pal-server.service"
mem_threshold=88  # 内存利用率百分比，超过这个百分比就会重启 pal-server

mem_usage_percent=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100.0)}')
#echo "System Memory Usage: $mem_usage_percent%"

current_time=$(date +"%Y-%m-%d %H:%M:%S")
if [ "$mem_usage_percent" -ge "$mem_threshold" ]; then
    # shellcheck disable=SC2028
    echo "\n[$current_time] Memory usage is above $mem_threshold%. Restarting service: $service_name..."
    sudo systemctl restart "$service_name"
fi