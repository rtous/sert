#!/bin/bash
set -x #echo on

#SBATCH --chdir=/scratch/nas/4/rtous/sert
#SBATCH --output=/scratch/nas/4/rtous/sert/data/output/sortida-%j.out
#SBATCH --error=/scratch/nas/4/rtous/sert/data/output/error-%j.out

source /scratch/nas/4/rtous/sert/myvenv/bin/activate

mkdir -p data/output

python cuda.py

