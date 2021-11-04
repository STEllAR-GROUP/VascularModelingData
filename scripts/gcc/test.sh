#!/bin/bash
source ~/src/spack/share/spack/setup-env.sh
spack load parallel

ranks=$1
gen=$2
dim=$3
NUM_CHUNKS=$1
seq 0 $(expr $NUM_CHUNKS - 1) | parallel -j 1 "./4-calc_radiation_dose_to_vessels.sh $ranks $gen $dim {}" 

