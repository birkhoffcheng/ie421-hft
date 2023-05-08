#!/bin/bash


if [ -e /usr/bin/python3 ]; then
	PYTHON_INTERP=python3
fi

if [ -e /usr/bin/pypy3.7 ]; then
	PYTHON_INTERP=pypy3.7
fi

if [ -e /var/lib/snapd/snap/bin/pypy3 ]; then
	PYTHON_INTERP=pypy3
fi


for pcap in $(ls *.gz);
do
    echo $pcap
	pcap_date=$(echo $pcap | sed -E 's/data_feeds_([0-9]{8})_[0-9]+_IEXTP.*/\1/')
	echo "PCAP_FILE=$pcap PCAP_DATE=$pcap_date"
	#gunzip -d -c $pcap | tcpdump -r - -w - -s 0 | $PYTHON_INTERP src/parse_iex_pcap.py /dev/stdin --symbols SPY
	gunzip -d -c $pcap | tcpdump -r - -w - -s 0 | $PYTHON_INTERP src/parse_iex_pcap.py /dev/stdin --symbols SPY --trade-date $pcap_date --output-deep-books-too

done;

