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
	@find hellow.deb

clean:
	rm -rf temp

vclean: clean
	rm -f hellow*.deb hellowdaemon.deb

install:
	dpkg -i hellow.deb  # Updated to match the output of debBuild.sh

uninstall:
	dpkg -r hellow

