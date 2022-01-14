#!/bin/bash
source /work/sshirzad/repos/VascularModelingData/spack/gcc_rostam.sh

ranks=$1
gen=$2
dim=$3
num_chunks=$(expr 1 \* $ranks)
echo $num_chunks
repo_dir="/work/sshirzad/repos/VascularModelingData"
exec_dir="${HOME}/src/VascularModeling/Radiation\ Modeling\ Projects/build/Output"
results_dir="${repo_dir}/results"
mkdir -p ${results_dir}
rm -rf ${results_dir}
mkdir -p ${results_dir}

NP="$HOME/src/VascularModeling/Radiation\ Modeling\ Projects/build/Output"
cd "${NP}" 

echo $PWD                                                    
echo "1-network generation"
echo "mpirun -n ${ranks} ${NP}/SimpleVesselGenerator ${gen} ${dim} ${results_dir}/geometry_${ranks}_${gen}_${dim}"

eval mpirun -n ${ranks} "${NP}/SimpleVesselGenerator" "${gen}" "${dim}" "${results_dir}/geometry_${ranks}_${gen}_${dim}"
echo "Done!"
h5dump "${results_dir}/geometry_${ranks}_${gen}_${dim}.h5">>"${results_dir}/1.txt"
echo "2-partition"
echo "mpirun -n ${ranks} "${NP}/NetworkPreprocessor" ${ranks} ${results_dir}/geometry_${ranks}_${gen}_${dim}.h5 "

eval mpirun -n "${ranks}" "${NP}/NetworkPreprocessor" "${ranks}" "${results_dir}/geometry_${ranks}_${gen}_${dim}.h5" 
echo "Done!"
h5dump "${results_dir}/geometry_${ranks}_${gen}_${dim}.h5">>"${results_dir}/2.txt"

#cd ${results_dir}
echo "3-dose_pipe_init"
echo "mpirun -n ${ranks} "${NP}/DosePipelineInit" -c ${num_chunks} --filename ${results_dir}/geometry_${ranks}_${gen}_${dim}.h5"

eval mpirun -n "${ranks}" "${NP}/DosePipelineInit" -c "${num_chunks}" --filename "${results_dir}/geometry_${ranks}_${gen}_${dim}.h5" # --result_name "${results_dir}/DoseResults" --timing_folder "${results_dir}/DoseTiming"
echo "Done!"
h5dump "${results_dir}/geometry_${ranks}_${gen}_${dim}.h5">>"${results_dir}/3.txt"

#
#ls "${NP}/DoseResults/*.h5"
#
mkdir -p "${results_dir}/DoseResults/"
mkdir -p "${results_dir}/DoseTiming/"

#rm "${results_dir}/DoseResults/*.h5"
#rm "${results_dir}/DoseTiming/*.csv"

cd ${results_dir}
echo "4-calc_radiation_dose_to_vessels"
eval seq 0 $(expr $num_chunks - 1) | parallel -j 1 "${NP}/VesselDoseCalcs" -c {} --filename "${results_dir}/geometry_${ranks}_${gen}_${dim}.h5"
echo "Done!"
h5dump "${results_dir}/geometry_${ranks}_${gen}_${dim}.h5">>"${results_dir}/4.txt"


echo "5-merge_dose_results_to_main"
echo "mpirun -n ${ranks} ${NP}/DoseMergeAnalysis --filename ${results_dir}/geometry_${ranks}_${gen}_${dim}.h5"

eval mpirun -n ${ranks} "${NP}/DoseMergeAnalysis" --filename "${results_dir}/geometry_${ranks}_${gen}_${dim}.h5"
echo "Done!"
h5dump "${results_dir}/geometry_${ranks}_${gen}_${dim}.h5">>"${results_dir}/5.txt"


echo "6-blood_flow_modeling"
echo "mpirun -n ${ranks} ${NP}/BloodFlowModeling -1 ${results_dir}/geometry_${ranks}_${gen}_${dim}.h5"

eval mpirun -n ${ranks} "${NP}/BloodFlowModeling" -1 "${results_dir}/geometry_${ranks}_${gen}_${dim}.h5"
echo "Done!"
h5dump "${results_dir}/geometry_${ranks}_${gen}_${dim}.h5">>"${results_dir}/6.txt"

