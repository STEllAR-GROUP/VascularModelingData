#!/bin/bash
repo_dir="/work/sshirzad/repos/VascularModelingData"
exec_dir="/home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build/Output"
results_dir="${repo_dir}/results"

source "${repo_dir}"/gcc_rostam.sh

ranks=$1
gen=$2
dim=$3
num_chunks=$4

echo $ranks,$gen,$dim,$num_chunks

repo_dir="/work/sshirzad/repos/VascularModelingData"
exec_dir="/home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build/Output"
results_dir="${repo_dir}/results"

echo "running DosePipelineInit on ${ranks} ranks for ${gen} generations and ${dim} dimensions"

echo "srun -p medusa -n ${ranks} --mpi=pmi2 ${exec_dir}/DosePipelineInit -c ${num_chunks} --filename ${results_dir}/geometry_${ranks}_${gen}_${dim}.h5"| tee ${results_dir}/DosePipelineInitlog_${ranks}_${gen}_${dim}.txt

cd /home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build/Output 
srun -p medusa -n ${ranks} --mpi=pmi2 ./DosePipelineInit -c ${num_chunks} --filename ${results_dir}/geometry_${ranks}_${gen}_${dim}.h5>>${results_dir}/DosePipelineInitlog_${ranks}_${gen}_${dim}.txt

echo "Done!"
