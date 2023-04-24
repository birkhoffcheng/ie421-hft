# hello-world-workflow

A tiny test CWL workflow written to help develop new features for Toil.
Also not a bad toy example for introducing yourself to CWL workflows.

## Running the workflow with Toil

Theoretically this should work with any CWL runner that supports
scattering and sub-workflows; but, assuming you want to use Toil:

1. First install Toil with the CWL extra by running

    ```
    pip install 'toil[cwl]'
    ```

2. run a vm locally

3. change the vmimage under ./steps/duplicate_file.cwl as the name of the vm

4. Run the main workflow with

    ```
    toil-cwl-runner hello_world_scatter_workflow.cwl config.yaml
    ```

If you want to get fancy by using Toil's advanced features, such as
autoscaling for AWS, Azure, or Google Cloud Platform, consult the
[official Toil documentation](http://toil.readthedocs.io/).

## Workflow breakdown

In the config file, [`config.yaml`](config.yaml), we have two lists: a
list of names, and a list of numbers. The main workflow,
[`hello_world_scatter_workflow.cwl`](hello_world_scatter_workflow.cwl),
"scatters" (i.e., takes every combination of) the names and numbers, and
runs each combination through the subworkflow
[`hello_world_subworkflow.cwl`](hello_world_subworkflow.cwl), which runs
the following steps:

### hello_world

The [hello_world step](steps/hello_world.cwl) takes a name and number
and prints a unique "hello world" message to a file.

### duplicate_file

The [duplicate_file step](steps/duplicate_file.cwl) takes the file from
hello_world and duplicates it into two separate files. This step is
(needlessly) run in the `node:slim` Docker container, to incorporate the
Docker feature into the workflow for testing purposes.

### make_caps

The [make_caps step](steps/make_caps.cwl) takes the files from
duplicate_file and converts all their alphabetic characters to uppercase
and creates a tarball with these converted files.

By default the final output tarballs created by make_caps should appear
in the base directory of the repository.
