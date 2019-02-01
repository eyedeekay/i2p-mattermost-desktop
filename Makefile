#!/usr/bin/make -f

MATTERMOST_LATEST=$(shell ./gh-latest.sh -u mattermost -r desktop | tr -d v)
MATTERMOST_ARCH="amd64"
MMC_HOST=127.0.0.1
MMC_PORT=8065
PROXY_PORT=4444
#PROXY_PORT=8118

PREFIX ?= /
VAR ?= var/
RUN ?= run/
LIB ?= lib/
LOG ?= log/
ETC ?= etc/
USR ?= usr/
LOCAL ?= local/

MATTERMOST_PROFILE=$(PREFIX)$(USR)$(LOCAL)/lib/mattermost.profile.i2p

echo:
	mkdir -p etc/i2pd/tunnels.d/ etc/mattermost-i2p
	@echo '[MatterMost]' | tee etc/i2pd/tunnels.d/mattermost.conf
	@echo 'type = client' | tee -a etc/i2pd/tunnels.d/mattermost.conf
	@echo 'address = 127.0.0.1' | tee -a etc/i2pd/tunnels.d/mattermost.conf
	@echo 'port = 8065' | tee -a etc/i2pd/tunnels.d/mattermost.conf
	@echo 'inbound.length = 2' | tee -a etc/i2pd/tunnels.d/mattermost.conf
	@echo 'outbound.length = 2' | tee -a etc/i2pd/tunnels.d/mattermost.conf
	@echo 'inbound.quantity =1' | tee -a etc/i2pd/tunnels.d/mattermost.conf
	@echo 'outbound.quantity = 1' | tee -a etc/i2pd/tunnels.d/mattermost.conf
	@echo 'inbound.backupQuantity = 1' | tee -a etc/i2pd/tunnels.d/mattermost.conf
	@echo 'outbound.backupQuanitity = 1' | tee -a etc/i2pd/tunnels.d/mattermost.conf
	@echo 'i2cp.gzip = true' | tee -a etc/i2pd/tunnels.d/mattermost.conf
	@echo "destination = $(MATTERMOST_DESTINATION).b32.i2p" | tee -a etc/i2pd/tunnels.d/mattermost.conf
	@echo 'destinationport = 8065' | tee -a etc/i2pd/tunnels.d/mattermost.conf
	@echo 'keys = mm-keys.dat' | tee -a etc/i2pd/tunnels.d/mattermost.conf
	@echo "MMC_HOST=$(MMC_HOST)" | tee etc/mattermost-i2p/mattermost-i2p.conf
	@echo "MMC_PORT=$(MMC_PORT)" | tee -a etc/mattermost-i2p/mattermost-i2p.conf
	@echo "PROXY_PORT=$(PROXY_PORT)" | tee -a etc/mattermost-i2p/mattermost-i2p.conf
	@echo "MATTERMOST_PROFILE=$(MATTERMOST_PROFILE)" | tee -a etc/mattermost-i2p/mattermost-i2p.conf
	#@echo "USER_MATTERMOST_PROFILE='~/.mozilla/firefox/mattermost.i2p'" | tee -a etc/mattermost-i2p/mattermost-i2p.conf

include config.mk
include launchers.mk
include ircbridge.mk
include test.mk

setup:
	make chromium firefox desktop desktop-proxy

install:
	mkdir -p $(PREFIX)$(ETC)/mattermost-i2p $(PREFIX)$(ETC)/i2pd/tunnels.d/ \
		$(PREFIX)$(USR)$(LOCAL)/lib/$(MATTERMOST_PROFILE)/ $(PREFIX)$(USR)$(LOCAL)/share/applications $(PREFIX)$(USR)$(LOCAL)/share/doc/assets/
	install -m755 usr/bin/mattermost-i2p $(PREFIX)$(USR)$(LOCAL)/bin/
	install -m755 usr/bin/mattermost-i2p-proxy $(PREFIX)$(USR)$(LOCAL)/bin/
	install -m755 usr/bin/mattermost-i2p-chromium $(PREFIX)$(USR)$(LOCAL)/bin/
	install -m755 usr/bin/mattermost-i2p-firefox $(PREFIX)$(USR)$(LOCAL)/bin/
	install etc/mattermost-i2p/mattermost-i2p.conf $(PREFIX)$(ETC)/mattermost-i2p/
	install etc/i2pd/tunnels.d/mattermost.conf $(PREFIX)$(ETC)/i2pd/tunnels.d/
	install usr/lib/$(MATTERMOST_PROFILE)/user.js $(MATTERMOST_PROFILE)/
	install usr/lib/$(MATTERMOST_PROFILE)/bookmarks.html $(MATTERMOST_PROFILE)/
	install usr/share/applications/mattermost-i2p.desktop $(PREFIX)$(USR)$(LOCAL)/share/applications
	install usr/share/applications/mattermost-i2p-proxy.desktop $(PREFIX)$(USR)$(LOCAL)/share/applications
	install usr/share/applications/mattermost-i2p-chromium.desktop $(PREFIX)$(USR)$(LOCAL)/share/applications
	install usr/share/applications/mattermost-i2p-firefox.desktop $(PREFIX)$(USR)$(LOCAL)/share/applications
	cp usr/share/doc/assets/*.png $(PREFIX)$(USR)$(LOCAL)/share/doc/assets

uninstall:
	rm -f $(PREFIX)$(USR)$(LOCAL)/bin/mattermost-i2p \
		$(PREFIX)$(USR)$(LOCAL)/bin/mattermost-i2p-proxy \
		$(PREFIX)$(USR)$(LOCAL)/bin/mattermost-i2p-chromium \
		$(PREFIX)$(USR)$(LOCAL)/bin/mattermost-i2p-firefox \
		$(PREFIX)$(ETC)/mattermost-i2p/mattermost-i2p.conf \
		$(PREFIX)$(ETC)/i2pd/tunnels.d/mattermost.conf \
		$(PREFIX)$(USR)$(LOCAL)/lib/$(MATTERMOST_PROFILE)/user.js \
		$(PREFIX)$(USR)$(LOCAL)/lib/$(MATTERMOST_PROFILE)/bookmarks.html \
		$(PREFIX)$(USR)$(LOCAL)/share/applications/mattermost-i2p.desktop \
		$(PREFIX)$(USR)$(LOCAL)/share/applications/mattermost-i2p-proxy.desktop \
		$(PREFIX)$(USR)$(LOCAL)/share/applications/mattermost-i2p-chromium.desktop \
		$(PREFIX)$(USR)$(LOCAL)/share/applications/mattermost-i2p-firefox.desktop \
		$(PREFIX)$(USR)$(LOCAL)/share/doc/assets/*.png

clean:
	rm -rf mattermost.profile.i2p.test

## Copyright (C) 2012 - 2018 ENCRYPTED SUPPORT LP <adrelanos@riseup.net>
## See the file COPYING for copying conditions.

## genmkfile - Makefile - version 1.5

## This is a copy.
## master location:
## https://github.com/Whonix/genmkfile/blob/master/usr/share/genmkfile/Makefile

#GENMKFILE_PATH ?= /usr/share/genmkfile
#GENMKFILE_ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

#export GENMKFILE_PATH
#export GENMKFILE_ROOT_DIR

#include $(GENMKFILE_PATH)/makefile-full
