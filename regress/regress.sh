#!/bin/sh

KEYID=$1

echo Testing ${KEYID}

python csr2dnskey.py \
	--csr regress/${KEYID}.csr \
	--output ${KEYID}.dnskey \
&& diff -u regress/${KEYID}.dnskey ${KEYID}.dnskey
