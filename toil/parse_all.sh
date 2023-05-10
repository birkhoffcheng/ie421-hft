#!/bin/bash


# if [ -e /usr/bin/python3 ]; then
PYTHON_INTERP=python
# fi

# if [ -e /usr/bin/pypy3.7 ]; then
# 	PYTHON_INTERP=pypy3.7
# fi

# if [ -e /var/lib/snapd/snap/bin/pypy3 ]; then
# 	PYTHON_INTERP=pypy3
# fi

for pcap in $(ls $1);
do
    pcap_date=$(echo $pcap | sed -r 's/.*data_feeds_(.*)_(.*)_IEXTP.*/\1/')
	echo "PCAP_FILE=$pcap PCAP_DATE=$pcap_date"
	#gunzip -d -c $pcap | tcpdump -r - -w - -s 0 | sudo $PYTHON_INTERP -u $2 /dev/stdin --symbols SPY --trade-date $pcap_date --output-deep-books-too
	zcat $pcap | tcpdump -r - -w - -s 0 | sudo $PYTHON_INTERP -u $2 /dev/stdin --symbols SPY --trade-date $pcap_date --output-deep-books-too
	#zcat $pcap | tcpdump -r - -w - -s 0 | sudo $PYTHON_INTERP src/parse_iex_pcap.py /dev/stdin --symbols SPY --trade-date $pcap_date --output-deep-books-too

done;

