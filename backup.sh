#!/bin/bash

# 备份目录的目标父目录
backup_parent_dir="/home/ubuntu/.steam/palback"

# 要备份的目录
source_dir="/home/steam/Steam/steamapps/common/PalServer/Pal/Saved"


# 获取当前日期
current_date=$(date +%Y%m%d)
current_time=$(date +%H%M%S)

# 备份目录的名称
backup_dir_name="${current_date}_${current_time}_games_backup"
backup_dir="${backup_parent_dir}/${backup_dir_name}"

# 创建备份目录
mkdir -p "${backup_dir}"

# 复制目录内容到备份目录
sudo cp -R "${source_dir}/." "${backup_dir}/"

# tar 命令打包后删除 backup_dir
backup_filename="${backup_dir}.tar.gz"
tar -cpzvf "${backup_filename}" "${backup_dir}" && sudo rm -rf "${backup_dir}"

# 删除该文件夹下超过 15 天的 tar.gz
find $backup_parent_dir -mtime +15 -name "*.tar.gz" -exec sudo rm -rf {} \;

current_time=$(date +"%Y-%m-%d %H:%M:%S")
echo -e "\n[$current_time] Backup finished, backup filename: $backup_filename"
