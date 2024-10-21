.PHONY: install build test publish release clean submodule_update check-licenses

install:
	sudo apt-get update
	sudo apt-get install -y bats bats-support bats-assert bats-file

test:
	bats test/test.bats

submodule_update:
	git submodule update

lint:
	shellcheck *.sh
