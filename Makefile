.PHONY: install build test publish release clean submodule_update check-licenses

install:
	sudo apt update && sudo apt install -y bats
	git submodule init
	git submodule update

test:
	bats test/test.bats

submodule_update:
	git submodule update

lint:
	shellcheck *.sh
