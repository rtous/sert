#!/bin/bash

#SBATCH --chdir=/scratch/nas/4/rtous

CSCRATCH=/scratch/nas/4/`whoami`

PROJECT_NAME=sert

CURRENT_ENVIRONMENT=`ls -d $CSCRATCH`/$PROJECT_NAME

source $CURRENT_ENVIRONMENT/bin/activate

python cuda.py

