#!/bin/bash
set -x #echo on

#SBATCH --chdir=/scratch/nas/4/rtous/sert
#SBATCH --output=/scratch/nas/4/rtous/sert/sortida-%j.out
#SBATCH --error=/scratch/nas/4/rtous/sert/error-%j.out

#CSCRATCH=/scratch/nas/4/`whoami`

#PROJECT_NAME=sert

#CURRENT_ENVIRONMENT=`ls -d $CSCRATCH`/$PROJECT_NAME

#source $CURRENT_ENVIRONMENT/bin/activate

echo 
source /scratch/nas/4/rtous/myvenv/bin/activate

python cuda.py

