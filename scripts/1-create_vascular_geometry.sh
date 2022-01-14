#!/bin/bash
repo_dir="/work/sshirzad/repos/VascularModelingData"
exec_dir="/home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build/Output"
results_dir="${repo_dir}/results"

source "${repo_dir}"/gcc_rostam.sh

ranks=$1
gen=$2
dim=$3

rm -rf ${results_dir}
mkdir -p ${results_dir}

echo "running SimpleVesselGenerator on ${ranks} ranks for ${gen} generations and ${dim} dimensions" | tee ${results_dir}/SimpleVesselGeneratorlog_${ranks}_${gen}_${dim}.txt

echo "srun -p medusa -n ${ranks} --mpi=pmi2 ${exec_dir}/SimpleVesselGenerator ${gen} ${dim} ${results_dir}/geometry_${ranks}_${gen}_${dim}">>${results_dir}/SimpleVesselGeneratorlog_${ranks}_${gen}_${dim}.txt

cd /home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build/Output
srun -p medusa -n ${ranks} --mpi=pmi2 SimpleVesselGenerator ${gen} ${dim} ${results_dir}/geometry_${ranks}_${gen}_${dim}>>${results_dir}/SimpleVesselGeneratorlog_${ranks}_${gen}_${dim}.txt

echo "Done!"
