#!/bin/bash
source /work/sshirzad/repos/VascularModelingData/spack/gcc.sh

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


repo_dir="/work/sshirzad/repos/VascularModelingData"
exec_dir="/home/sshirzad/src/VascularModeling/Radiation_Modeling_Projects/build/Output"
results_dir="${repo_dir}/results"
#rm -rf ${results_dir}
mkdir -p ${results_dir}

echo "running SimpleVesselGenerator on ${ranks} ranks for ${gen} generations and ${dim} dimensions" | tee ${results_dir}/SimpleVesselGeneratorlog_${ranks}_${gen}_${dim}.txt

echo "srun -p medusa -n ${ranks} --mpi=pmi2 ${exec_dir}/SimpleVesselGenerator ${gen} ${dim} ${results_dir}/geometry_${ranks}_${gen}_${dim}">>${results_dir}/SimpleVesselGeneratorlog_${ranks}_${gen}_${dim}.txt

cd /home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build/Output
srun -p medusa -n ${ranks} --mpi=pmi2 SimpleVesselGenerator ${gen} ${dim} ${results_dir}/geometry_${ranks}_${gen}_${dim}>>${results_dir}/SimpleVesselGeneratorlog_${ranks}_${gen}_${dim}.txt

echo "Done!"
