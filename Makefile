.PHONY: install build test publish release clean submodule_update check-licenses

install:
	sudo apt update; sudo apt install bats bats-assert bats-support

test:
	bats test/test.bats

submodule_update:
	git submodule update

lint:
	shellcheck *.sh
