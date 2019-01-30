#!/usr/bin/make -f

## Copyright (C) 2012 - 2018 ENCRYPTED SUPPORT LP <adrelanos@riseup.net>
## See the file COPYING for copying conditions.

## genmkfile - Makefile - version 1.5

## This is a copy.
## master location:
## https://github.com/Whonix/genmkfile/blob/master/usr/share/genmkfile/Makefile

PREFIX := /
VAR := var/
RUN := run/
LIB := lib/
LOG := log/
ETC := etc/
USR := usr/
LOCAL := local/

test:
	samcatd -h "127.0.0.1" -f etc/i2pd/tunnels.conf.d/mattermost.conf

GENMKFILE_PATH ?= /usr/share/genmkfile
GENMKFILE_ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

export GENMKFILE_PATH
export GENMKFILE_ROOT_DIR

include $(GENMKFILE_PATH)/makefile-full

#include ../local_conf.mk
include ../test_conf.mk

include launchers.mk

MATTERMOST_LATEST=$(shell ./gh-latest.sh -u mattermost -r desktop | tr -d v)
MATTERMOST_ARCH="amd64"
MMC_HOST=127.0.0.1
MMC_PORT=8065

echo:
	mkdir -p etc/i2pd/tunnels.conf.d/
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
	@echo "MMC_HOST=$MMC_HOST" | tee etc/mattermost-i2p/mattermost-i2p.conf
	@echo "MMC_PORT=$MMC_PORT" | tee -a etc/mattermost-i2p/mattermost-i2p.conf

clean:
	rm -fr firefox.profile.mattermost.test
