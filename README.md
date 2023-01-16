# sert

NEED: A DAC user and password plus a gateway password

## 1. Enter the gateway (replace 'rtous' with your username)

	ssh rtous@gw.ac.upc.edu 

## 2. Enter the cluster

	ssh sert 

## 3. Move to your scratch zone (use the proper path for your user)

	cd /scratch/nas/4/rtous

Check your quota with quota -s.

## 4. Create folder for the project (or obtain it from github)

	git clone https://github.com/rtous/sert.git
	cd sert

## 5. Create and activate a Python virtualenv

Check default python

	python --version  (3.10)

Check available python versions:

	ls /usr/bin/python*

Create a virtualenv witht the desired version (--no-cache-dir is important to avoid consuming quota in your home dir):

	python3.10 -m venv myvenv
	source myvenv/bin/activate
	pip --no-cache-dir install torch torchvision
	deactivate

## 6. Launch the script

### 6.1 CPU nodes

	sbatch example_job.sh

Or node group (no one for GPUs):

	sbatch --constraint=node-2017 example_job.sh

### 6.2 GPU node

	sbatch -A gpu -p gpu -q {cua} --gres=gpu:{nombre_gpus} example_job.sh

Example (pot trigar uns minuts a executar-se):

	sbatch -A gpu -p gpu -q small_gpu --gres=gpu:1 example_job.sh

Where cua:

	big_gpu (5-8 gpus, max 4 hores)
	medium_gpu (2-4 gpus, max 2 dies)
	small_gpu (1 gpus, max 3 dies, max 3 treballs) (default)

## 7. Monitor

	scontrol show jobid -dd <jobid>
	scancel <jobid>
	scontrol show node sert-2001

## 8. Amb launcher (per no haver de canviar els que ja tinc)

To avoid writting cluster-like versions for all your script you can use the launch.sh script:

	sbatch launch.sh example_launcher_job.sh

	(la sourtida està al slurm... al punt des d'on ell llença)