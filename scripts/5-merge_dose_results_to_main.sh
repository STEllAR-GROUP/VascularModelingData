#!/bin/bash
repo_dir="/work/sshirzad/repos/VascularModelingData"
exec_dir="/home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build/Output"
results_dir="${repo_dir}/results"

source "${repo_dir}"/gcc_rostam.sh

ranks=$1
gen=$2
dim=$3

if [ -z "$ranks" ]
then
        ranks=1
fi
if [ -z "$gen" ]
then
	gen=2
fi
if [ -z "$dim" ]
then
        dim=2
fi

echo "running DoseMergeAnalysis on ${ranks} ranks for ${gen} generations and ${dim} dimensions"

echo "srun -p medusa -n ${ranks} --mpi=pmi2 ${exec_dir}/DoseMergeAnalysis ${results_dir}/geometry_${ranks}_${gen}_${dim}.h5"| tee ${results_dir}/DoseMergeAnalysislog_${ranks}_${gen}_${dim}.txt

cd /home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build/Output 
#srun -p medusa -n ${ranks} --mpi=pmi2 -genv I_MPI_EXTRA_FILESYSTEM=on -genv I_MPI_EXTRA_FILESYSTEM_LIST=lustre DoseMergeAnalysis --filename ${results_dir}/geometry_${ranks}_${gen}_${dim}.h5>>${results_dir}/DoseMergeAnalysislog_${ranks}_${gen}_${dim}.txt

srun -p medusa -n ${ranks} --mpi=pmi2 DoseMergeAnalysis --filename ${results_dir}/geometry_${ranks}_${gen}_${dim}.h5>>${results_dir}/DoseMergeAnalysislog_${ranks}_${gen}_${dim}.txt


echo "Done!"
