
## It can be run in a browser like Chromium:

chromium:
	mkdir -p usr/bin
	@echo "#! /usr/bin/env sh" | tee usr/bin/mattermost-i2p-chromium
	@echo '. /etc/mattermost-i2p/mattermost-i2p.conf' | tee -a usr/bin/mattermost-i2p-chromium
	@echo 'chromium-browser --incognito \' | tee -a usr/bin/mattermost-i2p-chromium
	@echo "  --proxy-server=\"127.0.0.1:\$$PROXY_HOST\" \\" | tee -a usr/bin/mattermost-i2p-chromium
	@echo "  --proxy-bypass-list=\$$MMC_HOST:\$$MMC_PORT \\" | tee -a usr/bin/mattermost-i2p-chromium
	@echo "  \$$MMC_HOST:\$$MMC_PORT" | tee -a usr/bin/mattermost-i2p-chromium
	chmod +x usr/bin/mattermost-i2p-chromium

## Or in a browser like Firefox

firefox:
	@echo "#! /usr/bin/env sh" | tee usr/bin/mattermost-i2p-firefox
	@echo '. /etc/mattermost-i2p/mattermost-i2p.conf' | tee -a usr/bin/mattermost-i2p-firefox
	@echo "if [ ! -d \$$USER_MATTERMOST_PROFILE ]; then" | tee -a usr/bin/mattermost-i2p-firefox
	@echo "  cp -rv \$$MATTERMOST_PROFILE \$$USER_MATTERMOST_PROFILE" | tee -a usr/bin/mattermost-i2p-firefox
	@echo "fi" | tee -a usr/bin/mattermost-i2p-firefox
	@echo "firefox --no-remote --profile \$$USER_MATTERMOST_PROFILE \$$MMC_HOST:\$$MMC_PORT" | tee -a usr/bin/mattermost-i2p-firefox
	chmod +x usr/bin/mattermost-i2p-firefox

## It can be run in Mattermost Desktop:

github-helper:
	wget -c gh-latest.sh https://github.com/CraftShell/gh-latest/raw/master/gh-latest.sh
	sed -i 's|#! /bin/sh|#! /bin/bash|g' gh-latest.sh
	chmod +x gh-latest.sh

latest-url:
	@echo "https://releases.mattermost.com/desktop/$(MATTERMOST_LATEST)/mattermost-desktop-$(MATTERMOST_LATEST)-linux-$(MATTERMOST_ARCH).deb"

mattermost:
	wget -c "https://releases.mattermost.com/desktop/$(MATTERMOST_LATEST)/mattermost-desktop-$(MATTERMOST_LATEST)-linux-$(MATTERMOST_ARCH).deb"

## Via a tunnel:

desktop:
	mkdir -p usr/bin
	@echo "#! /usr/bin/env sh" | tee usr/bin/mattermost-i2p
	@echo '. /etc/mattermost-i2p/mattermost-i2p.conf' | tee -a usr/bin/mattermost-i2p
	@echo "/opt/Mattermost/mattermost-desktop --proxy-server=\"127.0.0.1:\$$PROXY_PORT\" --proxy-bypass-list=\"\$$MMC_HOST:\$$MMC_PORT\"" | tee -a usr/bin/mattermost-i2p
	chmod +x usr/bin/mattermost-i2p

## Or via the proxy

desktop-proxy:
	mkdir -p usr/bin
	@echo "#! /usr/bin/env sh" | tee usr/bin/mattermost-i2p-proxy
	@echo '. /etc/mattermost-i2p/mattermost-i2p.conf' | tee -a usr/bin/mattermost-i2p-proxy
	@echo '/opt/Mattermost/mattermost-desktop --proxy-server="127.0.0.1:$$PROXY_PORT"' | tee -a usr/bin/mattermost-i2p-proxy
	chmod +x usr/bin/mattermost-i2p-proxy
