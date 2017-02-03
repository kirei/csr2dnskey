VENV3=		venv3
PYTHON3=	python3

DISTDIRS=	*.egg-info build dist
TMPFILES=	K*.{dnskey,ds}


all:

lint:
	$(VENV3)/bin/pylint --reports=no *.py

wheel:
	python setup.py bdist_wheel

venv: $(VENV3)

$(VENV3):
	virtualenv -p $(PYTHON3) $(VENV3)
	$(VENV3)/bin/pip install -r requirements.txt

test: $(VENV3)
	(. $(VENV3)/bin/activate; $(MAKE) regress3_offline)

pip3:
	pip install -r requirements.txt

regress3_offline:
	python -m py_compile csr2dnskey.py
	sh regress.sh

clean:
	rm -fr $(DISTDIRS)
	rm -f $(TMPFILES)
	rm -fr __pycache__ *.pyc

realclean: clean
	rm -rf $(VENV3)
