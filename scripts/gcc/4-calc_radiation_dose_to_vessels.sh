#!/bin/bash
source /work/sshirzad/repos/VascularModelingData/spack/gcc.sh
ranks=$1
gen=$2
dim=$3
chunk_index=$4

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
echo $ranks,$gen,$dim,$chunk_index

repo_dir="/work/sshirzad/repos/VascularModelingData"
exec_dir="/home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build/Output"
results_dir="${repo_dir}/results"
#rm -rf ${results_dir}
mkdir -p ${results_dir}
echo "running VesselDoseCalcs on ${ranks} ranks for ${gen} generations, ${dim} dimensions, num chunks ${chunk_index}"

#echo "srun -p medusa -n ${ranks} --mpi=pmi2 
echo "${exec_dir}/VesselDoseCalcs -c ${chunk_index} --filename ${results_dir}/geometry_${ranks}_${gen}_${dim}.h5"| tee ${results_dir}/VesselDoseCalcslog_${ranks}_${gen}_${dim}_${chunk_index}.txt

export OMP_NUM_THREADS=20
cd /home/sshirzad/src/VascularModeling/Radiation\ Modeling\ Projects/build/Output 
#srun -p medusa -n ${ranks} --mpi=pmi2 
./VesselDoseCalcs -c ${chunk_index} --filename ${results_dir}/geometry_${ranks}_${gen}_${dim}.h5>>${results_dir}/VesselDoseCalcslog_${ranks}_${gen}_${dim}_${chunk_index}.txt

echo "Done!"
