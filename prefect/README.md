# Prefect

## Getting Started

```
pip install -U prefect
```



### Usage
#### Running the Prefect server
You can spin up an instance at any time with the `prefect server start CLI` command:
```
$ prefect server start
Starting...

 ___ ___ ___ ___ ___ ___ _____ 
| _ \ _ \ __| __| __/ __|_   _|
|  _/   / _|| _|| _| (__  | |
|_| |_|_\___|_| |___\___| |_|

Configure Prefect to communicate with the server with:

    prefect config set PREFECT_API_URL=http://127.0.0.1:4200/api

Check out the dashboard at http://127.0.0.1:4200
```
Here, if communicating with different vms, set the `PREFECT_API_URL` using the public IP of the master vm.


#### Create a work pool
For example, to create a work pool called test-pool, you would run this command:

```
$ prefect work-pool create test-pool

    Created work pool with properties:
        name - 'test-pool'
        id - a51adf8c-58bb-4949-abe6-1b87af46eabd
        concurrency limit - None

    Start an agent to pick up flows from the work pool:
        prefect agent start -p 'test-pool'

    Inspect the work pool:
        prefect work-pool inspect 'test-pool'
```
#### Starting an agent
Use the prefect agent start CLI command to start an agent. You must pass at least one work pool name or match string that the agent will poll for work. If the work pool does not exist, it will be created.
```
prefect agent start -p [work pool name]
```
In this case, Prefect automatically created a new my-queue work queue.

By default, the agent polls the API specified by the PREFECT_API_URL environment variable. 

#### Deploying a workflow
You can make a workflow to a deployment via the prefect deploy CLI command:

```
$ prefect deploy ./example.py:api_flow \
    -n my-first-deployment \
    -p WORK_POOL_NAME
```
This command will create a new deployment for your "Call API" flow with the name "my-first-deployment" that is attached to the `WORK_POOL_NAME` work pool.
