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

# Install & 
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
