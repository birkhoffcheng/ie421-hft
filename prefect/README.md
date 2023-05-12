# ETL Workflow with Prefect

## Prerequisites

You only need to do below steps if your system do not meet the requirements

#### Make sure you have enough volume for your vms

choose a path with enough volume for your vagrant to avoid memory issue

```
VBoxManage setproperty machinefolder </new/path>
```

#### Make sure you enable ssh between your vms

one should configure ssh capability amoung different vm in order to initiate a dask cluster. The procedure is

```
# On worker node
sudo sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
ssh-keygen

# On master node
# copy all public key of worker node (/home/vagrant/.ssh/id_rsa.pub) to master's /home/vagrant/.ssh/authorized_keys
ssh-copy-id VM_IP_1
ssh-copy-id VM_IP_2
...

```
## To start

1. Clone our repo
2. `vagrant up`
3. `bash make_deployments.sh`. This step is to initialize the prefect pipeline with dask cluster, you only need to do it once.
4. `vagrant ssh -c master "sudo python workflow/deploy.py"`. You can simply change the deployment to run by changing the deployment name in `deploy.py` file.


## Notification
The above mentioned workflow is designed as a tutorial, demonstrating the parallelization of two workflows that handle data download, data parsing, and stats computation on different dates. It is worth noting that modifying the workflow scripts to enable daily computation and incorporate more complex workflows is a straightforward process, as I have demonstrated by showcasing the combination of sequential and parallel execution.




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
First, when you try to run some experiment, maybe you need to change the `access_token` part (with your own personal access token) in `prefect.yaml` part in order for the Prefect agent to clone the repo successfully to their local fs.

You can make a workflow to a deployment via the prefect deploy CLI command:

```
# Run this command under the project root
$ prefect deploy ./prefect/example.py:api_flow \
    -n my-first-deployment \
    -p WORK_POOL_NAME
```
This command will create a new deployment for your "Call API" flow with the name "my-first-deployment" that is attached to the `WORK_POOL_NAME` work pool.
