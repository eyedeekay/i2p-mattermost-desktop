
## It can be run in a browser like Chromium:

chromium:
	mkdir -p usr/bin
	@echo "#! /usr/bin/env sh" | tee usr/bin/mattermost-chromium
	@echo '. /etc/mattermost-i2p/mattermost-i2p.conf' | tee -a usr/bin/mattermost-chromium
	@echo 'chromium --incognito \' | tee -a usr/bin/mattermost-chromium
	@echo "  --proxy-server=\"127.0.0.1:\$$PROXY_HOST\" \\" | tee -a usr/bin/mattermost-chromium
	@echo "  --proxy-bypass-list=\$$MMC_HOST:\$$MMC_PORT \\" | tee -a usr/bin/mattermost-chromium
	@echo "  \$$MMC_HOST:\$$MMC_PORT" | tee -a usr/bin/mattermost-chromium
	chmod +x usr/bin/mattermost-chromium

## Or in a browser like Firefox

firefox:
	@echo "#! /usr/bin/env sh" | tee usr/bin/mattermost-firefox
	@echo '. /etc/mattermost-i2p/mattermost-i2p.conf' | tee -a usr/bin/mattermost-firefox
	@echo "if [ -1 ~/.mozilla/firefox/mattermost.i2p ]; then" | tee -a usr/bin/mattermost-firefox
	@echo "  cp -rv /usr/lib/mattermost.profile.i2p ~/.mozilla/firefox/mattermost.i2p" | tee -a usr/bin/mattermost-firefox
	@echo "fi" | tee -a usr/bin/mattermost-firefox
	@echo "firefox --no-remote --profile ~/.mozilla/firefox/mattermost.i2p --private-window \$$MMC_HOST:\$$MMC_PORT" | tee -a usr/bin/mattermost-firefox
	chmod +x usr/bin/mattermost-firefox

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
