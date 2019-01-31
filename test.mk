
## It can be run in a browser like Chromium:

chromium-test:
	chromium --incognito --proxy-server="127.0.0.1:0" --proxy-bypass-list="127.0.0.1:8065" "127.0.0.1:8065" "127.0.0.1:7070"

## Or in a browser like Firefox

firefox-test:
	rm -rf ./mattermost.profile.i2p.test
	cp -rv ./usr/lib/mattermost.profile.i2p ./mattermost.profile.i2p.test
	firefox --no-remote --profile ./mattermost.profile.i2p.test --private-window $(MMC_HOST):$(MMC_PORT)

## Via a tunnel:

mattermost-test:
	http_proxy="http://127.0.0.1:4444" https_proxy="http://127.0.0.1:4444" no_proxy="127.0.0.1:8065" /opt/Mattermost/mattermost-desktop

## Or via the proxy

mattermost-proxy-test:
	http_proxy="http://127.0.0.1:4444" https_proxy="http://127.0.0.1:4444" /opt/Mattermost/mattermost-desktop

