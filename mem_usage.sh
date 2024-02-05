#!/bin/bash

mem_usage_percent=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100.0)}')
echo "System Memory Usage: $mem_usage_percent%"