#!/bin/bash

#USAGE: sbatch myjob.sh example_script.sh

PROJECT_PATH=/scratch/nas/4/rtous/sert

#SBATCH --chdir=/scratch/nas/4/rtous/sert
#SBATCH --output=/scratch/nas/4/rtous/sert/data/output/sortida-%j.out
#SBATCH --error=/scratch/nas/4/rtous/sert/data/output/error-%j.out

source $PROJECT_PATH/myvenv/bin/activate

### Run with all the incoming parameters
#cd $PROJECT_PATH/
INPUT=""
for var in "$@"
do
    INPUT=$INPUT" "$var
done
echo $INPUT
sh $INPUT
#"$1"





