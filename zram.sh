#!/bin/bash

echo "Installing zram..."
sudo apt update -y
sudo apt-get install zram-config -y
sudo systemctl start zram-config.service
