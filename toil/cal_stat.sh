#!/bin/bash

zcat $2 | python -u $1 -i /dev/stdin -o '$(date +%Y%m%d)_candle_chart.csv'