ENV = $(CURDIR)/env
PIP_INSTALL := $(ENV)/bin/pip install
DJANGO_ADMIN := $(ENV)/bin/django-admin
PYTEST := $(ENV)/bin/pytest
BLACK := $(ENV)/bin/black
IPYTHON := $(ENV)/bin/ipython

test: test-unit lint

lint: | $(BLACK)
	$(ENV)/bin/black . --check

test-unit: | $(PYTEST)
	$(PYTEST)

fmt: | $(BLACK)
	$(ENV)/bin/black .

start: | $(DJANGO_ADMIN)
	$(ENV)/bin/python manage.py runserver

shell: | $(DJANGO_ADMIN) $(IPYTHON)
	$(ENV)/bin/python manage.py shell

env:
	$(shell which python) -m venv env

$(DJANGO_ADMIN): | env
	$(PIP_INSTALL) pip --upgrade
	$(PIP_INSTALL) -r requirements/base.txt

$(IPYTHON) $(PYTEST) $(BLACK): |
	$(PIP_INSTALL) -r requirements/dev.txt

clean:
	rm -rf env
