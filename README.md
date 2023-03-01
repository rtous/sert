# sert

## Introduction 

SERT is a research cluster of the Department of Computer Architecture (DAC) of the UPC. It replaces the old ARVEI (sometimes this name is used in the docs). 

This repo provides help running experiments on the GPU nodes of the SERT cluster. You can go directly to the [official docs](https://www.ac.upc.edu/app/wiki/serveis-tic/Clusters/Users) instead.

NOTE: In order to be able to use the cluster you need an **username** and **password** provided by your project supervisor. 

## General cluster functionality

1) First, you access one of the *entry nodes* of the cluster via ssh (more on this later). Within the node, you can see the *scratch disk* (in /scratch), a shared disk accessible from all the nodes of the cluster (entry nodes and compute nodes) and also from outside. Look for a folder with your username there.

2) Within your scratch disk folder, setup a folder for your project (e.g. clone a github repo, create a python virtual environment, install dependencies, etc.).

3) Write a bash script (more info later), the *job script*, that executes an experiment (e.g. moves into the project folder, activates the python environment, runs a python command that trains a network, etc.). You can store it in your project folder. 

4) Execute a cluster command (e.g. sbatch) to program the execution of your bash script. Then you can leave, the script goes into a queue waiting to be executed by one of the *compute nodes* (it can take from seconds to hours depending on the cluster state). 

5) At some point a compute node will run your job script. The script will access your project folder (in the scratch disk), activate the virtual environment, run the python commands, etc. The logs and error messages generated during the execution will be stored in a file (e.g. slurm-33686.out). You can configure the location of this file with a directive in the job script.

## Quick start (demo experiment)

### Enter the DAC network 

In order to access the cluster you need to be within the DAC network. You can get there throught:
	- [DAC VPN](https://www.ac.upc.edu/app/wiki/serveis-tic/Gateway/VPN)
	- [DAC gateway](https://www.ac.upc.edu/app/wiki/serveis-tic/Gateway/SSH)

For instance, you can enter the gateway typing (replace 'rtous' with your username) i the terminal:

	ssh rtous@gw.ac.upc.edu 

### Enter the cluster

From within the DAC network you access the cluster with:

	ssh sert 

You will be within one of the *entry nodes* of the cluster. From there you can also see the scratch disk and your project folder. 

### Prepare a project folder in the shared scratch disk

Move to your scratch zone (use the proper path for your user):

	cd /scratch/nas/4/rtous

Check your quota with quota -s.

Create folder for the project (or obtain it from github). For this demo directly use:

	git clone https://github.com/rtous/sert.git
	cd sert

Check default python:

	python --version

Check available python versions:

	ls /usr/bin/python*

Create a virtualenv with the desired version (--no-cache-dir is **important** to avoid consuming quota in your home dir):

	python3.10 -m venv myvenv
	source myvenv/bin/activate
	pip --no-cache-dir install torch torchvision
	deactivate
	mkdir -p data/output

You deactivate the virtual environment as it will be activated later when a compute node will run the job script.

### Create a job script that launches your program

For this demo you can use example_job.sh, already in this repo:
```
	#!/bin/bash
	#SBATCH --chdir=/scratch/nas/4/rtous/sert
	#SBATCH --output=/scratch/nas/4/rtous/sert/data/output/sortida-%j.out
	#SBATCH --error=/scratch/nas/4/rtous/sert/data/output/error-%j.out
	source /scratch/nas/4/rtous/sert/myvenv/bin/activate	
	python cuda.py
```

The script combines conventional commands with cluster directives. The demo script runs a python program that checks if pytorch can use the GPU.

### Launch the job script

To program the execution of the script on the GPU node do:

	sbatch -A gpu -p gpu -q small_gpu --gres=gpu:1 example_job.sh

Take note of the job id.

The template for this command is:

	sbatch -A gpu -p gpu -q {<queue>} --gres=gpu:{<number of GPUs>} example_job.sh

Where queue can be:

	big_gpu (5-8 gpus, max 4 hores)
	medium_gpu (2-4 gpus, max 2 dies)
	small_gpu (1 gpus, max 3 dies, max 3 treballs) (default)

### Monitor your job

To see the status of the job:

	scontrol show jobid -dd <jobid>

To see the status of the node:

	scontrol show node sert-2001

To cancel the job (don't do that now!):

	scancel <jobid>

### See the results of your job

In the job script we have specified that output errors and logs will be stored into data/output (within the project folder).

### Moving data in/out the cluster

Use the scp command. For example to bring a results directory from the cluster (if you are within the DAC VPN):

	scp rtous@sert.ac.upc.edu:/scratch/nas/4/rtous/sert/data/output/results .

If you are using the DAC gateway you can do:

	scp rtous@gw.ac.upc.edu:/scratch/nas/4/rtous/sert/data/output/results .

## ANNEX. Use a "universal" job script 

Instead of having a job script for each one of your experiments it's a good practice to use a unique job script (with the cluster directives) that calls conventional bash scripts for your experiments. You still need to write the bash scripts but they are not cluster-specific, you can use them in your local environment too, this is the point. 

In this repo there's an example, launch.sh. It's used this way:

	sbatch -A gpu -p gpu -q small_gpu --gres=gpu:1 launch.sh example_launcher_job.sh
