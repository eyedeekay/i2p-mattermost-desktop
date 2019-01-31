
## It can be run in a browser like Chromium:

chromium-test:
	chromium --incognito --proxy-server="127.0.0.1:4444" --proxy-bypass-list="127.0.0.1:8065" "127.0.0.1:8065" "127.0.0.1:7070"

## Or in a browser like Firefox

firefox-test:
	rm -rf ./mattermost.profile.i2p.test
	cp -rv ./usr/lib/mattermost.profile.i2p ./mattermost.profile.i2p.test
	firefox --no-remote --profile ./mattermost.profile.i2p.test --private-window "127.0.0.1:8065"

## Via a tunnel:

mattermost-test:
	/opt/Mattermost/mattermost-desktop --incognito --proxy-server="127.0.0.1:4444" --proxy-bypass-list="127.0.0.1:8065" "127.0.0.1:8065"

## Or via the proxy

mattermost-proxy-test:
	/opt/Mattermost/mattermost-desktop --incognito --proxy-server="127.0.0.1:4444"

brave-test:
	brave-browser --incognito --proxy-server="127.0.0.1:4444" --proxy-bypass-list="127.0.0.1:8065" "127.0.0.1:8065" "127.0.0.1:7070"
