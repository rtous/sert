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

## 6. Create and script



	#!/bin/bash

	#SBATCH --chdir=/scratch/nas/4/rtous

	CSCRATCH=/scratch/nas/4/`whoami`



	#!/bin/bash

	PROJECT_NAME=test

	CSCRATCH=/scratch/nas/4/`whoami`

	#SBATCH --chdir=/scratch/nas/4/`whoami`

	DATA=data.$JOB_ID

	### Borrar antics logs
	#rm $HOME/*

	### Crear zona de datos local y transferir datos
	#mkdir $DATA
	#rsync $CSCRATCH/exSimul/data $DATA
	# La otra opción es que la aplicación lea de $CSCRATCH

	### Prepare Python virtualenv
	CURRENT_ENVIRONMENT=`ls -d $CSCRATCH`/$PROJECT_NAME
	source $CURRENT_ENVIRONMENT/bin/activate

	### Run with all the incoming parameters
	cd $CSCRATCH/$PROJECT_NAME/
	INPUT=""
	for var in "$@"
	do
	    INPUT=$INPUT" "$var
	done
	echo $INPUT
	sh $INPUT
	#"$1"

	### Copy stdout and stderr (now in files within the execution node) outside:
	cp $HOME/* $CSCRATCH/$PROJECT_NAME/output/

	### Copiar salida (comprimida)
	#gzip -c $DATA/output-$1-$2 > $CSCRATCH/out/output-$1-$2.gz

	### Borrar zona datos local
	rm -rf $DATA




## 7. Launch the script

	sbatch myjob.sh


	sbatch noise.sh

	qsub -S /bin/bash -N run_v1_step0_metadata -M YOUR_EMAI_ADDRESS -l big ./arvei/launch.sh ./scripts/step0_metadata.sh

To the GPUs node:

	sbatch --constraint=sert-2001 myjob.sh


