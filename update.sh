#!/bin/bash

steamcmd_path=$(which steamcmd)
steam_user=steam
systemd_unit=pal-server
sudo -u $steam_user $steamcmd_path +login anonymous +app_update 2394010 validate +quit

sudo systemctl restart $systemd_unit
sudo systemctl -l --no-pager status $systemd_unit

current_time=$(date +"%Y-%m-%d %H:%M:%S")
if systemctl --quiet is-active "$systemd_unit"
then
    echo -e "\n[$current_time] PalServer is running successfully, enjoy!"
else
    echo -e "\n[$current_time] There were some problems with the installation."
fi