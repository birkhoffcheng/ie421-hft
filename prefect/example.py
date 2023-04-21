import requests
from prefect import flow, task
from prefect.task_runners import SequentialTaskRunner
import time

@task
def call_api(url):
    response = requests.get(url)
    print(response.status_code)
    return response.json()

@task(name="My Example Task", 
      description="An example task for a tutorial.",
      retries=2, retry_delay_seconds=60)
def parse_fact(response):
    fact = response["fact"]
    print(fact)
    return fact

@task
def print_values(values):
    for value in values:
        time.sleep(0.5)
        print(value, end="\r")

# the tasks in flow will be running concurrently in default
@flow
def sub_flow():
    print_values.submit(["AAAA"] * 15)
    print_values.submit(["BBBB"] * 10)

@flow(name="My Example Flow",
      description="An example flow for a tutorial.",
      task_runner=SequentialTaskRunner())
def api_flow():
    url = "https://catfact.ninja/fact"
    fact_json = call_api(url)
    sub_flow()
    fact_text = parse_fact(fact_json)
    return fact_text
