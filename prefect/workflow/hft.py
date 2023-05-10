
from prefect import flow, task
from prefect.task_runners import SequentialTaskRunner
import datetime
from prefect_dask.task_runners import DaskTaskRunner
import subprocess


@task
def download_iex_pcaps(date):
    command = f"sudo python workflow/download_iex_pcaps.py --start-date {date} --end-date {date} --download-dir vagrant_data"
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    if process.returncode != 0:
        print(f"Something went wrong: {stderr}")
    else:
        print(stdout)


@task
def parse_iex_pcaps(date):
    formatted_date = date.replace("-", "")
    command = f"zcat vagrant_data/DEEP/*{formatted_date}*.gz | tcpdump -r - -w - -s 0 | sudo python workflow/parse_iex_pcaps.py /dev/stdin --symbols SPY --trade-date {formatted_date} --output-deep-books-too"
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    if process.returncode != 0:
        print(f"Something went wrong: {stderr}")
    else:
        print(stdout)


@task
def compute_candle_chart(date):
    formatted_date = date.replace("-", "")
    command = f"zcat vagrant_data/book_snapshots/{formatted_date}_trades.csv.gz | sudo python workflow/compute_candle_chart.py -i /dev/stdin -o vagrant_data/{formatted_date}_candle_chart.csv"
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    if process.returncode != 0:
        print(f"Something went wrong: {stderr}")
    else:
        print(stdout)


@flow(flow_run_name="Model downloading Flow",
      description="Model downloading Flow.",
      task_runner=DaskTaskRunner(address="tcp://192.168.50.101:8786"))
def download_iex_pcaps_flow(dates):
    for date in dates:
        download_iex_pcaps.submit(date)

@flow(flow_run_name="Model parsing Flow",
      description="Model parsing Flow.",
      task_runner=DaskTaskRunner(address="tcp://192.168.50.101:8786"))
def parse_iex_pcaps_flow(dates):
    for date in dates:
        parse_iex_pcaps.submit(date)

@flow(flow_run_name="Stats computing Flow",
      description="Stats computing Flow.",
      task_runner=DaskTaskRunner(address="tcp://192.168.50.101:8786"))
def compute_candle_chart_flow(dates):
    for date in dates:
        compute_candle_chart.submit(date)


@flow(task_runner=SequentialTaskRunner())
def hft_flow():
    dates=["2022-08-01", "2022-08-02"]
    download_iex_pcaps_flow(dates)
    parse_iex_pcaps_flow(dates)
    compute_candle_chart_flow(dates)

hft_flow()


