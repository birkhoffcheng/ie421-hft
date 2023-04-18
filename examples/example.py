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
    'Download and Parse IEX PCAPs',
    default_args=default_args,
    description='Download and Parse IEX PCAP files',
    schedule_interval=timedelta(days=1),
)

t1 = BashOperator(
    task_id='download pcap files of the day',
    bash_command='python3 /usr/local/iexdownloaderparser/src/download_iex_pcaps.py --start-date $(date +%Y-%m-%d) --end-date $(date +%Y-%m-%d) --download-dir /usr/local/iexdownloaderparser/data',
    dag=dag,
)

t2 = BashOperator(
    task_id='parse pcap files of the day',
    bash_command='gunzip -d -c /usr/local/iexdownloaderparser/data/*$(date +%Y%m%d)*DEEP*.gz | tcpdump -r - -w - -s 0 | python3 /usr/local/iexdownloaderparser/src/parse_iex_pcaps.py /dev/stdin --symbols ALL --trade-date $(date +%Y%m%d) --output-deep-books-too',
    dag=dag,
)

t1 >> t2
