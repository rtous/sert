#!/bin/bash

#SBATCH --chdir=/scratch/nas/4/rtous/sert
#SBATCH --output=/scratch/nas/4/rtous/sert/data/output/sortida-%j.out
#SBATCH --error=/scratch/nas/4/rtous/sert/data/output/error-%j.out

source /scratch/nas/4/rtous/sert/myvenv/bin/activate

python cuda.py

