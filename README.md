# PalWorld-Scripts

[An article about how to use this script collection](https://u0htbttevtr.feishu.cn/wiki/H6QTwjqYWi6GdXkGxNlcL50Lnkg?from=from_copylink)

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

$ ./auto_runner.sh

$ crontab -l
* * * * * /bin/bash /home/ubuntu/PalWorld-Scripts/restart.sh >> /tmp/pal-restart.log 2>&1
0 4 * * * /bin/bash /home/ubuntu/PalWorld-Scripts/update.sh >> /tmp/pal-update.log 2>&1
0 3 * * * /bin/bash /home/ubuntu/PalWorld-Scripts/backup.sh >> /tmp/pal-backup.log 2>&1

$ ./mem_usage.sh
System Memory Usage: 36%
```
