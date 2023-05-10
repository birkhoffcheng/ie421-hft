#!/usr/bin/env python3

import argparse
import csv

OPEN = 0
CLOSE = 1
HIGH = 2
LOW = 3

def compute_candle_chart(input_file, output_file):
	stocks = {}
	with open(input_file, 'r') as f:
		reader = csv.reader(f)
		header = next(reader)
		symbol_index = header.index('SYMBOL')
		price_index = header.index('PRICE')
		for row in reader:
			symbol = row[symbol_index]
			price = float(row[price_index])
			if symbol not in stocks:
				stocks[symbol] = [price, price, price, price]
			else:
				stocks[symbol][CLOSE] = price
				stocks[symbol][HIGH] = max(stocks[symbol][HIGH], price)
				stocks[symbol][LOW] = min(stocks[symbol][LOW], price)

	with open(output_file, 'w') as f:
		writer = csv.writer(f)
		writer.writerow(['SYMBOL', 'OPEN', 'CLOSE', 'HIGH', 'LOW'])
		for symbol in stocks:
			writer.writerow([symbol] + stocks[symbol])

parser = argparse.ArgumentParser(description='Compute open, close, high, low of each symbol')
parser.add_argument('-i', '--input', dest='input', help='Input file name', required=True)
parser.add_argument('-o', '--output', dest='output', help='Output file name', required=True)
args = parser.parse_args()

compute_candle_chart(args.input, args.output)
