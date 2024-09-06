.PHONY: install build test publish release clean submodule_update

test:
	./test/bats/bin/bats test/test.bats

submodule_update:
	git submodule update

lint:
	shellcheck *.sh
