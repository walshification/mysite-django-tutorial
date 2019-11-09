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
	pipenv run pytest .

fmt: | $(BLACK)
	pipenv run isort --recursive .
	pipenv run autoflake --recursive --in-place --remove-all-unused-imports --remove-unused-variables .
	pipenv run black .


start: | $(DJANGO_ADMIN)
	$(ENV)/bin/python manage.py runserver

shell: | $(DJANGO_ADMIN) $(IPYTHON)
	pipenv shell

$(ENV):
	pipenv install

$(DJANGO_ADMIN): | env
	$(PIP_INSTALL) pip --upgrade
	$(PIP_INSTALL) -r requirements/base.txt

$(IPYTHON) $(PYTEST) $(BLACK) $(FLAKE8): | $(ENV)

clean:
	pipenv --rm
