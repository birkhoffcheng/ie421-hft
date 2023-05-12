# Apache Airflow

This documentation provides a step-by-step guide to setting up a Vagrant environment for a financial data warehouse using Apache Airflow DAG framework. The goal is to collect and analyze daily open, high, low, close, and volume data of a specific stock. Second-accurate data can also be computed via an optional argument.

## Prerequisites

```
vagrant
virtualbox
```

## Setup

```
git clone --recursive https://gitlab.engr.illinois.edu/ie421_high_frequency_trading_spring_2023/ie421_hft_spring_2023_group_03/group_03_project.git
cd group_03_project/airflow
vagrant up
```

Browse to [localhost:8080](http://localhost:8080) and use the WebUI to trigger the `download-and-parse-iex-pcaps` DAG. And the resulting data csv will be stored in the current directory.
