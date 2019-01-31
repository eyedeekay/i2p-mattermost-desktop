
GOPATH=$(shell pwd)/go
MMIRCBIN="$(GOPATH)/bin/matterircd"

matterircd-bin:
	go get -u github.com/42wim/matterircd

matter-config: etc/pki/tls/matterircd-i2p/key.pem
	@echo '# source this file to generate keys for your matterbridge server'
	@echo 'openssl req -newkey rsa:4096 -new -nodes \-x509 -days 3650 \' \
		| tee etc/pki/tls/matterircd-i2p/.keys_go_here
	@echo '    -keyout /etc/pki/tls/matterircd-i2p/key.pem -out /etc/pki/tls/matterircd-i2p/cert.pem' \
		| tee -a etc/pki/tls/matterircd-i2p/.keys_go_here
	touch etc/pki/tls/matterircd-i2p/.keys_go_here

matter: matter-config
	$(MMIRCBIN) -conf etc/matterircd/matterircd.toml

etc/pki/tls/matterircd-i2p/key.pem:
	mkdir -p etc/pki/tls/matterircd-i2p/
	test etc/pki/tls/matterircd-i2p/key.pem || openssl req -newkey rsa:4096 \
		-new -nodes -x509 -days 3650 \
		-keyout etc/pki/tls/matterircd-i2p/key.pem \
		-out etc/pki/tls/matterircd-i2p/cert.pem
