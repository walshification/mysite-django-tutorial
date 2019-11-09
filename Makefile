ENV = $(shell pipenv --venv)
DJANGO_ADMIN := $(ENV)/bin/django-admin
PYTEST := $(ENV)/bin/pytest
BLACK := $(ENV)/bin/black
FLAKE8 := $(ENV)/bin/flake8
IPYTHON := $(ENV)/bin/ipython

test: test-unit lint

lint: | $(BLACK) $(FLAKE8)
	pipenv run black . --check
	pipenv run flake8
	pipenv run isort --recursive --check-only .

test-unit: | $(PYTEST)
	pipenv run pytest --cov
	pipenv run coverage html

fmt: | $(BLACK)
	pipenv run isort --recursive .
	pipenv run autoflake --recursive --in-place --remove-all-unused-imports --remove-unused-variables .
	pipenv run black .


start: | $(DJANGO_ADMIN)
	pipenv run python manage.py runserver

shell: | $(DJANGO_ADMIN) $(IPYTHON)
	pipenv run python manage.py shell

$(ENV) init:
	pipenv install

ci-env:
	pip install pip --upgrade
	pip install pipenv
	pipenv install --dev

$(IPYTHON) $(PYTEST) $(BLACK) $(FLAKE8): | $(ENV)
	pipenv install --dev

clean:
	pipenv --rm
