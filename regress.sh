#!/bin/sh

for csr in regress/*.csr; do
	KEYID=`basename $csr .csr`

	echo "Testing ${KEYID}:"

	python csr2dnskey.py \
		--csr regress/${KEYID}.csr \
		--no-ds --dnskey \
		--output ${KEYID}.dnskey.tmp

	diff -u regress/${KEYID}.dnskey ${KEYID}.dnskey.tmp
	if [ $? -eq 0 ]; then
		echo "${KEYID} DNSKEY OK"
	else
		echo "${KEYID} DNSKEY FAIL"
		exit -1
	fi

	python csr2dnskey.py \
		--csr regress/${KEYID}.csr \
		--ds --no-dnskey \
		--output ${KEYID}.ds.tmp

	diff -u regress/${KEYID}.ds ${KEYID}.ds.tmp
	if [ $? -eq 0 ]; then
		echo "${KEYID} DS OK"
	else
		echo "${KEYID} DS FAIL"
		exit -1
	fi

done
