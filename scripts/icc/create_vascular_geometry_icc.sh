#!/bin/bash
source /work/sshirzad/repos/VascularModeling/spack/icc.sh
ranks=$1
gen=$2
dim=$3

if [ -z "$ranks" ]
then
        ranks=2
fi
if [ -z "$gen" ]
then
	gen=3
fi
if [ -z "$dim" ]
then
        dim=4
fi


repo_dir="/work/sshirzad/repos/VascularModeling"
exec_dir="/home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build_icc/Output"
results_dir="${repo_dir}/results_icc"
rm -rf ${results_dir}
mkdir -p ${results_dir}
echo "running SimpleVesselGenerator on ${ranks} ranks for ${gen} generations and ${dim} dimensions"

echo "srun -p medusa -n ${ranks} --mpi=pmi2 ${exec_dir}/SimpleVesselGenerator ${gen} ${dim} ${results_dir}/geometry_${ranks}_${gen}_${dim}">>${results_dir}/SimpleVesselGeneratorlog_${ranks}_${gen}_${dim}.txt
cd /home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build_icc/Output 
srun -p medusa -n ${ranks} --mpi=pmi2 SimpleVesselGenerator ${gen} ${dim} ${results_dir}/geometry_${ranks}_${gen}_${dim}>>${results_dir}/SimpleVesselGeneratorlog_${ranks}_${gen}_${dim}.txt

echo "Done!"
