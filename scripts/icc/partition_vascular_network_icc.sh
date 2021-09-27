#!/bin/bash
source /work/sshirzad/repos/VascularModeling/spack/icc.sh
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


repo_dir="/work/sshirzad/repos/VascularModeling"
exec_dir="/home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build_icc/Output"
results_dir="${repo_dir}/results_icc"
#rm -rf ${results_dir}
mkdir -p ${results_dir}
echo "running NetworkPreprocessor on ${ranks} ranks for ${gen} generations and ${dim} dimensions"

echo "srun -p medusa -n ${ranks} --mpi=pmi2 ${exec_dir}/NetworkPreprocessor ${results_dir}/geometry_${ranks}_${gen}_${dim}.h5"| tee ${results_dir}/NetworkPreprocessorlog_${ranks}_${gen}_${dim}.txt
cd /home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build_icc/Output 
srun -p medusa -n ${ranks} --mpi=pmi2 NetworkPreprocessor ${ranks} ${results_dir}/geometry_${ranks}_${gen}_${dim}.h5>>${results_dir}/NetworkPreprocessorlog_${ranks}_${gen}_${dim}.txt

echo "Done!"
