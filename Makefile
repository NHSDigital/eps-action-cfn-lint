.PHONY: install build test publish release clean submodule_update check-licenses

install:
	sudo apt-get update
	sudo apt-get install -y git bats
	git clone https://github.com/ztombol/bats-support /usr/lib/bats/bats-support/bats-support
	git clone https://github.com/ztombol/bats-assert /usr/lib/bats/bats-support/bats-assert

test:
	bats test/test.bats

submodule_update:
	git submodule update

lint:
	shellcheck *.sh
