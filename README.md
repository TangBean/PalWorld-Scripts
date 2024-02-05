# PalWorld-Scripts

PalWorld commonly used scripts.

First fo all, add execute permission for every script:

```sh
chmod +x *.sh
```

## Install

```sh
# Only install
./install.sh 

# Install & Enable zram & Enable auto restart
./install.sh --enable-zram --enable-auto-restart
```

## Auto restart base on memory usage rate

```sh
./auto_restart.sh
```

## Daily auto update Pal Server

```sh
./auto_update.sh
```

## Install ZRAM

```sh
./zram.sh
```

## Print memory usage rate

```sh
./mem_usage.sh
```

## Example

```sh
$ cd PalWorld-Scripts

$ ls
auto_restart.sh  auto_update.sh  install.sh  mem_usage.sh  README.md  restart.sh  update.sh  zram.sh

$ chmod +x *.sh

$ ./auto_restart.sh
Restart script name: /home/ubuntu/PalWorld-Scripts/restart.sh
no crontab for ubuntu

$ ./auto_update.sh
Restart script name: /home/ubuntu/PalWorld-Scripts/update.sh

$ crontab -l
* * * * * /bin/bash /home/ubuntu/PalWorld-Scripts/restart.sh >> /tmp/pal-restart.log 2>&1
0 4 * * * /bin/bash /home/ubuntu/PalWorld-Scripts/update.sh >> /tmp/pal-update.log 2>&1

$ ./mem_usage.sh
System Memory Usage: 36%
```
