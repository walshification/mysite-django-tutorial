.PHONY: lint test-unit test clean install

test: test-unit lint

lint:
	pipenv run black . --check

test-unit:
	pipenv run pytest

fmt:
	pipenv run black .

install:
	pipenv install

clean:
	pipenv rm
