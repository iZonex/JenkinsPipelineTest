# Some simple testing tasks (sorry, UNIX only). (base example from aiohttp)

all: test

.install-deps: $(shell find requirements -type f)
	@pip install -U -r requirements/dev.txt
	@touch .install-deps

isort:
	isort -rc app
	isort -rc tests
	isort -rc examples

flake: .flake

.flake: .install-deps $(shell find app -type f) \
                      $(shell find tests -type f)
	@flake8 app tests
	python setup.py check -rms
	@if ! isort -c -rc app tests ; then \
            echo "Import sort errors, run 'make isort' to fix them!!!"; \
            isort --diff -rc app tests; \
            false; \
	fi
	@touch .flake

check_changes:
	@./tools/check_changes.py

mypy: .flake
	if python -c "import sys; sys.exit(sys.implementation.name!='cpython')"; then \
            mypy app tests; \
	fi

.develop: .install-deps $(shell find app -type f) .flake check_changes mypy
	@pip install -e .
	@touch .develop

test: .develop
	@pytest -q ./tests

vtest: .develop
	@pytest -s -v ./tests

cov cover coverage:
	tox

cov-dev: .develop
	@echo "Run without extensions"
	@pytest --cov=app tests
	@pytest --cov=app --cov-report=term --cov-report=html --cov-append tests
	@echo "open file://`pwd`/htmlcov/index.html"

cov-ci-no-ext: .develop
	@echo "Run without extensions"
	@pytest --cov=app tests
cov-ci-aio-debug: .develop
	@echo "Run in debug mode"
	@PYTHONASYNCIODEBUG=1 pytest --cov=app --cov-append tests
cov-ci-run: .develop
	@echo "Regular run"
	@pytest --cov=app--cov-report=term --cov-report=html --cov-append tests

cov-dev-full: cov-ci-no-ext cov-ci-aio-debug cov-ci-run
	@echo "open file://`pwd`/htmlcov/index.html"

clean:
	@rm -rf `find . -name __pycache__`
	@rm -f `find . -type f -name '*.py[co]' `
	@rm -f `find . -type f -name '*~' `
	@rm -f `find . -type f -name '.*~' `
	@rm -f `find . -type f -name '@*' `
	@rm -f `find . -type f -name '#*#' `
	@rm -f `find . -type f -name '*.orig' `
	@rm -f `find . -type f -name '*.rej' `
	@rm -f .coverage
	@rm -rf htmlcov
	@rm -rf build
	@rm -rf cover
	@make -C docs clean
	@python setup.py clean
	@rm -rf .tox
	@rm -f .develop
	@rm -f .flake
	@rm -f .install-deps

doc:
	@make -C docs html SPHINXOPTS="-W -E"
	@echo "open file://`pwd`/docs/_build/html/index.html"

doc-spelling:
	@make -C docs spelling SPHINXOPTS="-W -E"

install:
	@pip install -U pip
	@pip install -Ur requirements/dev.txt

.PHONY: all build flake test vtest cov clean doc