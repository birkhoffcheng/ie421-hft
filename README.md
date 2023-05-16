# group_03_project

## Members

Birkhoff Cheng (zhiqic2@illinois.edu): Responsible for building analysis software and setup using Apache Airflow framework

Kaiyang Chen (kc68@illinois.edu): Responsible for distributed workflow setup using Prefect framework

Samuel Olmos Ruiz (so30@illinois.edu) : Responsible for the implementation of the datawarehouse using Apache Airflow framework

Haozhen Zheng (haozhen3@illinois.edu): Responsible for cwl workflow setup using Toil framework

## Airflow
Apache Airflow is an open-source platform designed to programmatically author, schedule, and monitor workflows. It enables the creation and orchestration of complex data pipelines by providing a rich set of tools and features. Airflow allows users to define workflows as Directed Acyclic Graphs (DAGs), where each node represents a task and the edges denote the dependencies between tasks.

### Advantages of Apache Airflow
1. Scalability: Airflow supports distributed execution, allowing you to scale your workflows across multiple machines or clusters. This makes it suitable for handling large-scale data processing tasks.
2. Flexibility: Airflow offers a highly flexible and extensible architecture. You can easily define and customize your workflows using Python, making it straightforward to integrate with existing systems and libraries.
3. Monitoring and Alerting: Airflow provides a web-based user interface that allows you to monitor the status and progress of your workflows. It also supports alerts and notifications, enabling you to take action based on predefined conditions or failures.
4. Dependency Management: Airflow manages task dependencies automatically, ensuring that tasks execute in the correct order. It also supports complex dependency patterns, such as branching and joining, to handle intricate workflow scenarios.
5. Extensive Ecosystem: Airflow has a vibrant and active community, resulting in a rich ecosystem of plugins and integrations. This allows you to leverage a wide range of pre-built operators and hooks for interacting with various systems, databases, and cloud platforms.

### Disadvantages of Apache Airflow
1. Learning Curve: Airflow has a steep learning curve, especially for beginners who are new to workflow orchestration concepts. Understanding the core concepts and best practices may require some time and effort.
2. Resource Overhead: Airflow requires dedicated resources for its operation, including a database for metadata storage, a web server, and an executor. Setting up and managing these resources can be cumbersome, especially for small-scale deployments.
3. Lack of Real-Time Capabilities: Airflow is primarily designed for batch processing and scheduled workflows. While it supports triggering tasks based on events, it may not be suitable for real-time processing scenarios where low-latency is critical.
4. Complex Deployment and Configuration: Deploying and configuring Airflow for production use can be complex, involving multiple components and settings. Managing high availability and fault tolerance requires additional setup and maintenance.

### Conclusion
Despite these challenges, Apache Airflow remains a powerful tool for managing and orchestrating data workflows, providing a flexible and scalable solution for organizations dealing with complex data processing tasks.

## Prefect
Prefect is a modern dataflow automation framework that aims to simplify and streamline the creation, deployment, and management of complex data workflows. It is designed to handle failures and unexpected exceptions gracefully, ensuring that your data pipeline remains resilient. Prefect offers both an open-source engine for creating workflows and a commercial platform for orchestration and deployment.

### Advantages of Prefect
1. Error handling: Prefect was designed to handle failures and errors out of the box. This greatly reduces the time spent on debugging and fixing pipelines.
2. Flexibility: Prefect is highly flexible and allows for dynamic pipeline creation. You can create complex workflows that can change dynamically based on the data or the state of other tasks.
3. Ease of use: Prefect has an intuitive Pythonic interface and provides good abstractions for task dependencies.
4. Scalability: Prefect can scale to support large workflows, both in terms of the number of tasks and the amount of data.
5. Cloud-native: Prefect's commercial offering, Prefect Cloud, provides a robust platform for deploying and managing your workflows in the cloud.

### Disadvantages of Prefect
1. Learning curve: While Prefect's Pythonic interface is intuitive, it can still have a learning curve, particularly for complex workflows.
2. Community support: Prefect is newer than other workflow management systems, so it may not have as large a community or as many resources available.
3. Lack of certain features: There are certain features available in other workflow management systems that are not yet available in Prefect. For example, when doing distributed workflow, prefect does not support naively for different processes among different vms. One should first running a Dask cluster among vms, and then build a distributed prefect based ono that

### Comparisons
Prefect vs Airflow: Prefect was actually built by some of the same developers as Airflow, and it was designed to address some of the shortcomings they saw in Airflow. For example, Prefect has a more intuitive interface and better error handling out of the box. However, Airflow has been around longer and has a larger community and more plugins available.

Prefect vs Toil: Toil is a workflow engine for computational (particularly bioinformatics) workflows. It focuses on portable, reproducible runs and supports a variety of computing backends including grid computing and cloud computing. Prefect, on the other hand, is more general-purpose and is designed for a wide range of data workflows. It provides a higher-level, more intuitive abstraction for defining workflows, whereas Toil workflows can be more complex to define but offer lower-level control.

### Summary
In summary, the best choice of workflow management system depends on your specific needs and use case.

## Toil
Toil is an open-source workflow engine that allows users to run scientific computations and data analyses on a variety of distributed computing platforms.

### Advantage of Toil
1. Toil workflows support a variety of task execution modes, including single-machine, multi-core parallelism, and distributed computing, allowing users to optimize their workflow performance based on their computational resources.
2. Toil provides built-in support for job retries, checkpointing, and recovery, ensuring that workflows can recover from failures and continue running without losing progress. 
3. Toil supports job scaling and autoscaling, allowing users to dynamically adjust their workflow resources to match changing compute demands.
4. Toil fully supports CWL and provides a test version for handling basic WDL files.

### Disadvantage of Toil
1. Toil requires users to specify the resource requirements for their workflows, or risk running out of memory or disk space. By default, Toil allocates only 1GB for both memory and disk space, which may not be sufficient for larger workflows.
2. During workflow execution, Toil creates a temporary directory and pulls input files into this environment to prevent accidental modification of other files in the same directory. However, Toil only allows output files to be written to the same working directory that is specified, and it does not have writing access to other directories.
3. Toil does not have a user interface for visualizing workflow tasks, which can make it challenging to monitor the progress of a workflow.
4. Toil only supports distributed systems via Docker API on the local machine, which means that it cannot be used to run workflows distributed by Vagrant VMs.

### Conclusion
In summary, while Toil provides a flexible and fault-tolerant framework for running scientific computations on distributed computing platforms, users should be aware of its limitations and plan accordingly when using it for larger workflows.
