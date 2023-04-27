# Documents by Birkhoff

Python package requirements of download and parsing scripts:

```
requests
tqdm
pytz
```

## Usage of market stats scripts
compute_open_close_high_low.py: computes the open, close, low, and high of each symbol in the given CSV file
```
./compute_open_close_high_low.py --file input_trade_file.csv --output output.csv
```
