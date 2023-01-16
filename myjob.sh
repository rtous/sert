#!/bin/bash
set -x #echo on

#SBATCH --chdir=/scratch/nas/4/rtous/sert
#SBATCH --output=/scratch/nas/4/rtous/sert/sortida-%j.out
#SBATCH --error=/scratch/nas/4/rtous/sert/error-%j.out

source /scratch/nas/4/rtous/sert/myvenv/bin/activate

python cuda.py

