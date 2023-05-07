
from prefect import flow, task
from prefect.task_runners import SequentialTaskRunner
import datetime
from prefect_dask.task_runners import DaskTaskRunner





@task
def write_values(values, filename):
    with open(filename, 'w') as f:
        f.write(str(values))

@task
def copy_file(source_filename, target_filename):
    with open(source_filename, 'r') as source_file:
        with open(target_filename, 'w') as target_file:
            target_file.write(source_file.read())

# @flow(flow_run_name="workflow-on-{date:%A}",
#       task_runner=SequentialTaskRunner())
# def hft_flow(date: datetime.datetime):
#     write_values.submit(date,'/data/test1')
#     copy_file.submit('/data/test1', '/data/test2')


@flow(flow_run_name="My Main Flow on {date:%A}",
      description="An example flow for a tutorial.",
      task_runner=DaskTaskRunner(address="tcp://192.168.50.101:8786"))
def api_flow(date: datetime.datetime):
    write_values.submit(date,'/data/test1')
    copy_file.submit('/data/test1', '/data/test2')


api_flow(date=datetime.datetime.utcnow())

