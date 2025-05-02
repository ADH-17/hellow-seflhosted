SHELL = /bin/sh

build:
	@echo "Nothing to build for a Python project"


test:
	@echo "running test harness"

lint:
	@echo "Running linter..."
	@./tools/lint.py

build-deb:
	@echo "Building deb file"
	./debBuild.sh
	@echo "Deb file location:"
	@find . -name "counter*.deb"

clean:
	rm -rf temp

vclean: clean
	rm -f counter*.deb countdaemon.deb

install:
	dpkg -i counter.deb  # Updated to match the output of debBuild.sh

uninstall:
	dpkg -r counter

