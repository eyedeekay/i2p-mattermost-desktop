#!/usr/bin/make -f

MATTERMOST_LATEST=$(shell ./gh-latest.sh -u mattermost -r desktop | tr -d v)
MATTERMOST_ARCH="amd64"
MMC_HOST=127.0.0.1
MMC_PORT=8065
PROXY_PORT=4444
#PROXY_PORT=8118

PREFIX := /
VAR := var/
RUN := run/
LIB := lib/
LOG := log/
ETC := etc/
USR := usr/
LOCAL := local/


echo: etc/privoxy/i2p-config
	mkdir -p etc/i2pd/tunnels.conf.d/ etc/mattermost-i2p etc/privoxy
	@echo '[MatterMost]' | tee etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo 'type = client' | tee -a etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo 'address = 127.0.0.1' | tee -a etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo 'port = 8065' | tee -a etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo 'inbound.length = 2' | tee -a etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo 'outbound.length = 2' | tee -a etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo 'inbound.quantity =1' | tee -a etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo 'outbound.quantity = 1' | tee -a etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo 'inbound.backupQuantity = 1' | tee -a etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo 'outbound.backupQuanitity = 1' | tee -a etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo 'i2cp.gzip = true' | tee -a etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo "destination = $(MATTERMOST_DESTINATION).b32.i2p" | tee -a etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo 'destinationport = 8065' | tee -a etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo 'keys = mm-keys.dat' | tee -a etc/i2pd/tunnels.conf.d/mattermost.conf
	@echo "MMC_HOST=$(MMC_HOST)" | tee etc/mattermost-i2p/mattermost-i2p.conf
	@echo "MMC_PORT=$(MMC_PORT)" | tee -a etc/mattermost-i2p/mattermost-i2p.conf
	@echo "PROXY_PORT=$(PROXY_PORT)" | tee -a etc/mattermost-i2p/mattermost-i2p.conf

etc/privoxy/i2p-config:
	cat	/etc/privoxy/config | grep -v '#' | tee etc/privoxy/i2p-config
	echo 'forward-socks5t / 127.0.0.1:9050 .' | tee -a etc/privoxy/i2p-config
	echo 'forward .i2p 127.0.0.1:4444' | tee -a etc/privoxy/i2p-config

#include ../local_conf.mk
include ../test_conf.mk

include launchers.mk
include ircbridge.mk
include test.mk

setup:
	make chromium firefox desktop desktop-proxy

## Copyright (C) 2012 - 2018 ENCRYPTED SUPPORT LP <adrelanos@riseup.net>
## See the file COPYING for copying conditions.

## genmkfile - Makefile - version 1.5

## This is a copy.
## master location:
## https://github.com/Whonix/genmkfile/blob/master/usr/share/genmkfile/Makefile

GENMKFILE_PATH ?= /usr/share/genmkfile
GENMKFILE_ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

export GENMKFILE_PATH
export GENMKFILE_ROOT_DIR

include $(GENMKFILE_PATH)/makefile-full


