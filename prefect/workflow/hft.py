
from prefect import flow, task
from prefect.task_runners import SequentialTaskRunner
import datetime
from prefect_dask.task_runners import DaskTaskRunner
import subprocess


def download_iex_pcaps(date):
    command = f"sudo python workflow/download_iex_pcaps.py --start-date {date} --end-date {date} --download-dir vagrant_data"
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    if process.returncode != 0:
        print(f"Something went wrong: {stderr}")
    else:
        print(stdout)



def parse_iex_pcaps(date):
    formatted_date = date.replace("-", "")
    command = f"zcat vagrant_data/DEEP/*{formatted_date}*.gz | tcpdump -r - -w - -s 0 | sudo python workflow/parse_iex_pcaps.py /dev/stdin --symbols SPY --trade-date {formatted_date} --output-deep-books-too"
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    if process.returncode != 0:
        print(f"Something went wrong: {stderr}")
    else:
        print(stdout)



def compute_candle_chart(date):
    formatted_date = date.replace("-", "")
    command = f"zcat vagrant_data/book_snapshots/{formatted_date}_trades.csv.gz | sudo python workflow/compute_candle_chart.py -i /dev/stdin -o vagrant_data/{formatted_date}_candle_chart.csv"
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    if process.returncode != 0:
        print(f"Something went wrong: {stderr}")
    else:
        print(stdout)


@task
def compute(date):
    download_iex_pcaps(date)
    parse_iex_pcaps(date)
    compute_candle_chart(date)

@task
def copy_file(source_filename, target_filename):
    with open(source_filename, 'r') as source_file:
        with open(target_filename, 'w') as target_file:
            target_file.write(source_file.read())



@flow(flow_run_name="My Main Flow on {date:%A}",
      description="An example flow for a tutorial.",
      task_runner=DaskTaskRunner(address="tcp://192.168.50.101:8786"))
def hft_flow(dates):
    for date in dates:
        compute.submit(date)


hft_flow(["2022-08-01", "2022-08-02"])


