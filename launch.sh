#!/bin/bash

#SBATCH --chdir=/scratch/nas/4/rtous/sert
#SBATCH --output=/scratch/nas/4/rtous/sert/data/output/sortida-%j.out
#SBATCH --error=/scratch/nas/4/rtous/sert/data/output/error-%j.out

source /scratch/nas/4/rtous/sert/myvenv/bin/activate

### Run with all the incoming parameters
INPUT=""
for var in "$@"
do
    INPUT=$INPUT" "$var
done
echo $INPUT
sh $INPUT





