#!/usr/bin/env python3

import argparse
import csv

def compute_candle_chart(input_file, output_file, seconds_output_file=None):
	HIGH = 1
	LOW = 2
	CLOSE = 3
	VOLUME = 4
	stocks = {}
	if seconds_output_file:
		secs_stats = {}
	with open(input_file, 'r') as f:
		reader = csv.reader(f)
		header = next(reader)
		symbol_index = header.index('SYMBOL')
		price_index = header.index('PRICE')
		size_index = header.index('SIZE')
		time_index = header.index('COLLECTION_TIME')
		for row in reader:
			symbol = row[symbol_index]
			price = float(row[price_index])
			size = int(row[size_index])
			if symbol not in stocks:
				stocks[symbol] = [price, price, price, price, size]
			else:
				stocks[symbol][HIGH] = max(stocks[symbol][HIGH], price)
				stocks[symbol][LOW] = min(stocks[symbol][LOW], price)
				stocks[symbol][CLOSE] = price
				stocks[symbol][VOLUME] += size

			if seconds_output_file:
				time = row[time_index]
				time = time.split('.')[0]
				k = time, symbol
				if k not in secs_stats:
					secs_stats[k] = [price, price, price, price, size]
				else:
					secs_stats[k][HIGH] = max(secs_stats[k][HIGH], price)
					secs_stats[k][LOW] = min(secs_stats[k][LOW], price)
					secs_stats[k][CLOSE] = price
					secs_stats[k][VOLUME] += size

	with open(output_file, 'w') as f:
		writer = csv.writer(f)
		writer.writerow(['SYMBOL', 'OPEN', 'HIGH', 'LOW', 'CLOSE', 'VOLUME'])
		for symbol in stocks:
			writer.writerow([symbol] + stocks[symbol])

	if seconds_output_file:
		with open(seconds_output_file, 'w') as f:
			writer = csv.writer(f)
			writer.writerow(['TIME', 'SYMBOL', 'OPEN', 'HIGH', 'LOW', 'CLOSE', 'VOLUME'])
			for k in secs_stats:
				writer.writerow([k[0], k[1]] + secs_stats[k])

parser = argparse.ArgumentParser(description='Compute open, close, high, low of each symbol')
parser.add_argument('-i', '--input', dest='input', help='Input file name', required=True)
parser.add_argument('-o', '--output', dest='output', help='Output file name', required=True)
parser.add_argument('-s', '--seconds-stats', dest='seconds_output', help='Stats accurate to seconds', required=False)
args = parser.parse_args()

compute_candle_chart(args.input, args.output, args.seconds_output)
