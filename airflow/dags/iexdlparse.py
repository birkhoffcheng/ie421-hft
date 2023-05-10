from datetime import timedelta

import airflow
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': airflow.utils.dates.days_ago(2),
    'email': ['airflow@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
    # 'queue': 'bash_queue',
    # 'pool': 'backfill',
    # 'priority_weight': 10,
    # 'end_date': datetime(2016, 1, 1),
    # 'wait_for_downstream': False,
    # 'dag': dag,
    # 'adhoc':False,
    # 'sla': timedelta(hours=2),
    # 'execution_timeout': timedelta(seconds=300),
    # 'on_failure_callback': some_function,
    # 'on_success_callback': some_other_function,
    # 'on_retry_callback': another_function,
    # 'trigger_rule': u'all_success'
}

dag = DAG(
    dag_id='download-and-parse-iex-pcaps',
    default_args=default_args,
    description='Download and Parse IEX PCAP files',
    schedule="0 23 * * 1-5",
    start_date=pendulum.datetime(2023, 1, 1, tz="UTC"),
    catchup=False,
    dagrun_timeout=datetime.timedelta(minutes=60)
)

t1 = BashOperator(
    task_id='download-pcap-files-of-the-day',
    bash_command='python3 /vagrant/src/download_iex_pcaps.py --start-date $(date +%Y-%m-%d) --end-date $(date +%Y-%m-%d) --download-dir /vagrant/data/iex_downloads',
    dag=dag,
)

t2 = BashOperator(
    task_id='parse-pcap-files-of-the-day',
    bash_command='zcat /vagrant/data/iex_downloads/DEEP/*$(date +%Y%m%d)*.gz | tcpdump -r - -w - -s 0 | python3 /vagrant/src/parse_iex_pcaps.py /dev/stdin --symbols SPY --trade-date $(date +%Y%m%d) --output-deep-books-too',
    dag=dag,
)

t3 = BashOperator(
    task_id='compute-candle-chart-data',
    bash_command='zcat /vagrant/data/book_snapshots/$(date +%Y%m%d)_trades.csv.gz | python3 /vagrant/src/compute_candle_chart.py -i /dev/stdin -o /vagrant/$(date +%Y%m%d)_candle_chart.csv',
    dag=dag,
)

t1 >> t2 >> t3
