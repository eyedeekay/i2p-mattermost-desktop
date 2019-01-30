
## It can be run in a browser like Chromium:

chromium-mattermost-i2p:
	mkdir -p usr/bin
	@echo "#! /usr/bin/env sh" | tee usr/bin/mattermost-chromium
	@echo '. /etc/mattermost-i2p/mattermost.conf' | tee -a usr/bin/mattermost-chromium
	@echo 'chromium --incognito \' | tee -a usr/bin/mattermost-chromium
	@echo '  --proxy-server="127.0.0.1:0" \' | tee -a usr/bin/mattermost-chromium
	@echo "  --proxy-bypass-list=\$$MMC_HOST:\$$MMC_PORT \\" | tee -a usr/bin/mattermost-chromium
	@echo "  \$$MMC_HOST:\$$MMC_PORT" | tee -a usr/bin/mattermost-chromium
	chmod +x usr/bin/mattermost-chromium

chromium-test:
	chromium --incognito --proxy-server="127.0.0.1:0" --proxy-bypass-list="127.0.0.1:8065" "127.0.0.1:8065" "127.0.0.1:7070"

## Or in a browser like Firefox

firefox-mattermost-i2p:
	@echo "#! /usr/bin/env sh" | tee usr/bin/mattermost-firefox
	@echo '. /etc/mattermost-i2p/mattermost.conf' | tee -a usr/bin/mattermost-firefox
	@echo "if [ -1 ~/.mozilla/firefox/mattermost.i2p ]; then" | tee -a usr/bin/mattermost-firefox
	@echo "  cp -rv /usr/lib/mattermost.profile.i2p ~/.mozilla/firefox/mattermost.i2p" | tee -a usr/bin/mattermost-firefox
	@echo "fi" | tee -a usr/bin/mattermost-firefox
	@echo "firefox --no-remote --profile ~/.mozilla/firefox/mattermost.i2p --private-window \$$MMC_HOST:\$$MMC_PORT" | tee -a usr/bin/mattermost-firefox
	chmod +x usr/bin/mattermost-firefox

firefox-test:
	rm -rf ./mattermost.profile.i2p.test
	cp -rv ./usr/lib/mattermost.profile.i2p ./mattermost.profile.i2p.test
	firefox --no-remote --profile ./mattermost.profile.i2p.test --private-window $(MMC_HOST):$(MMC_PORT)

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

desktop-mattermost-i2p:
	mkdir -p usr/bin
	@echo "#! /usr/bin/env sh" | tee usr/bin/mattermost-i2p
	@echo '. /etc/mattermost-i2p/mattermost.conf' | tee -a usr/bin/mattermost-i2p
	@echo 'export http_proxy="http://127.0.0.1:4444"' | tee -a usr/bin/mattermost-i2p
	@echo 'export https_proxy="http://127.0.0.1:4444"' | tee -a usr/bin/mattermost-i2p
	@echo "export no_proxy=http://\$$MMC_HOST:\$$MMC_PORT" | tee -a usr/bin/mattermost-i2p
	@echo '/opt/Mattermost/mattermost-desktop' | tee -a usr/bin/mattermost-i2p
	chmod +x usr/bin/mattermost-i2p

mattermost-test:
	http_proxy="http://127.0.0.1:4444" https_proxy="http://127.0.0.1:4444" no_proxy="127.0.0.1:8065" /opt/Mattermost/mattermost-desktop

## Or via the proxy

desktop-mattermost-i2p-proxy:
	mkdir -p usr/bin
	@echo "#! /usr/bin/env sh" | tee usr/bin/mattermost-i2p-proxy
	@echo 'export http_proxy="http://127.0.0.1:4444"' | tee -a usr/bin/mattermost-i2p-proxy
	@echo 'export https_proxy="http://127.0.0.1:4444"' | tee -a usr/bin/mattermost-i2p-proxy
	@echo '/opt/Mattermost/mattermost-desktop' | tee -a usr/bin/mattermost-i2p-proxy
	chmod +x usr/bin/mattermost-i2p-proxy

mattermost-proxy-test:
	http_proxy="http://127.0.0.1:4444" https_proxy="http://127.0.0.1:4444" /opt/Mattermost/mattermost-desktop

all: echo desktop-mattermost-i2p-proxy desktop-mattermost-i2p chromium-mattermost-i2p firefox-mattermost-i2p
