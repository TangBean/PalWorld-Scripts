#!/bin/bash

enable_zram=false
enable_auto_restart=false
server_port=""

for arg in "$@"
do
    case $arg in
        --enable-zram)
        enable_zram=true
        ;;
        --enable-auto-restart)
        enable_auto_restart=true
        ;;
        --server-port=*)
        server_port="${arg#*=}"
        ;;
    esac
done

steam_user=steam
log_path=/tmp/pal_server.log
sudo rm /tmp/pal_server.log

if getent passwd "$steam_user" >/dev/null 2>&1; then
    echo "User $steam_user exists."
else
    echo "User $steam_user does not exist.Adding $steam_user ..."
    sudo useradd -m -s /bin/bash $steam_user
fi

steam_user_path=~steam
exec_start="$steam_user_path/Steam/steamapps/common/PalServer/PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"

# Apply arguments
current_path=$(dirname "$(readlink -f "$0")")

zram_script_name=zram.sh
zram_script_name="$current_path/$zram_script_name"
echo "ZRAM script name: $zram_script_name"
chmod +x "$zram_script_name"

restart_script_name=restart.sh
restart_script_name="$current_path/$restart_script_name"
echo "Restart script name: $restart_script_name"
chmod +x "$restart_script_name"

if [ "$enable_zram" = true ]; then
    echo "Enabling Zram..."
    sh "$zram_script_name"
fi

if [ "$enable_auto_restart" = true ]; then
    echo "Enabling auto restart on high memory usage..."
    sh "$restart_script_name"
fi

if [ ! -z "$server_port" ]; then
    echo "PAL server port set to $server_port"
    exec_start="$exec_start -port=$server_port"
fi



echo "Installing SteamCMD..."

sudo add-apt-repository multiverse -y > $log_path
sudo dpkg --add-architecture i386 >> $log_path
sudo apt update -y >> $log_path
sudo apt-get remove needrestart -y >> $log_path

echo steam steam/license note '' | sudo debconf-set-selections
echo steam steam/question select "I AGREE" | sudo debconf-set-selections
sudo apt install steamcmd -y >> $log_path


steamcmd_path=$(which steamcmd)

if [ -z "$steamcmd_path" ]; then
    echo "Error: Install SteamCMD failed"
    exit 1
else
    echo "Install SteamCMD successfully"
fi

sudo -u $steam_user mkdir -p $steam_user_path/.steam/sdk64/ >> $log_path
echo "Downloading palServer..."
sudo -u $steam_user $steamcmd_path +login anonymous +app_update 1007 validate +quit >> $log_path
sudo -u $steam_user $steamcmd_path +login anonymous +app_update 2394010 validate +quit >> $log_path

sudo cp $steam_user_path/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so $steam_user_path/.steam/sdk64/

systemd_unit=pal-server
cat <<EOF > $systemd_unit.service
[Unit]
Description=$systemd_unit.service

[Service]
Type=simple
User=$steam_user
Restart=on-failure
RestartSec=30s
ExecStart=$exec_start

[Install]
WantedBy=multi-user.target
EOF

sudo mv $systemd_unit.service /usr/lib/systemd/system/
echo "Starting palServer..."
sudo systemctl enable $systemd_unit
sudo systemctl restart $systemd_unit
sudo systemctl -l --no-pager status $systemd_unit

if systemctl --quiet is-active "$systemd_unit"
then
    echo -e "\nPalServer is running successfully, enjoy!"
else
    echo -e "\nThere were some problems with the installation, please check the log $log_path."
fi