#!/usr/bin/env make

include Makehelp.mk

###Core

## Create uv.lock for venv
uvsync:
	uv sync --no-install-project --all-extras --upgrade
	uv lock --check
.PHONY: uvsync


## Create/activate python virtualenv
venv:
	uv sync --no-install-project --frozen
.PHONY: venv


## Perform unit tests
test:
	uv run coverage run -m pytest -v
	uv run coverage xml -o reports/coverage.xml
	uv run coverage report
.PHONY: test


## Perform fmt, lint and type checks
check: check-fmt check-lint check-type
.PHONY: check


## Perform code format using ruff
check-fmt:
	uv run ruff format --check src tests
.PHONY: check-fmt


## Perform pylint check
check-lint:
	uv run ruff check .
.PHONY: check-lint


## Perform mypy check
check-type:
	uv run mypy src tests
.PHONY: check-type


## Format python code using ruff
fmt:
	uv run ruff format src tests
	uv run ruff check --fix src tests
.PHONY: fmt


## Execute pyprojectversion script
run:
	uv run pyprojectversion
.PHONY: run


## Clean python artefacts
clean:
	@find lambdas -type f -name "*.pyc" -delete
	@find lambdas -type d -name "__pycache__" -delete
	@rm -rf .pytest_cache .ruff_cache reports
	@echo "Cleanup complete."
.PHONY: clean

