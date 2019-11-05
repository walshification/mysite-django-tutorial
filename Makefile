PIPENV_RUN := pipenv run

.PHONY: lint test-unit test clean install

test: test-unit lint

lint:
	$(PIPENV_RUN) black . --check

test-unit:
	$(PIPENV_RUN) pytest

fmt:
	$(PIPENV_RUN) black .

start:
	$(PIPENV_RUN) python manage.py runserver

install:
	pipenv install

clean:
	pipenv rm
