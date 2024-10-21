.PHONY: install build test publish release clean submodule_update check-licenses

install:
	sudo apt-get update
	sudo apt-get install -y git
	sudo mkdir -p /usr/lib/bats
	sudo chmod -R 777 /usr/lib/bats
	git clone https://github.com/bats-core/bats-support /usr/lib/bats/bats-support
	git clone https://github.com/bats-core/bats-assert /usr/lib/bats/bats-assert
	git clone https://github.com/sstephenson/bats.git /tmp/bats
	cd /tmp/bats
	./install.sh /usr/local
	cd -

test:
	bats test/test.bats

submodule_update:
	git submodule update

lint:
	shellcheck *.sh
