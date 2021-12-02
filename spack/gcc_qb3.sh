module purge
module load gcc/9.3.0
module load mvapich2/2.3.3/gcc-9.3.0
source $HOME/src/spack/share/spack/setup-env.sh
spack env activate my_env
spack load googletest%gcc@9.3.0
spack load /xxpwssmdxuyri25hs37jkfwuq7eidrwo #parmetis%gcc@9.3.0
spack load clhep%gcc@9.3.0
spack load /7dzrwealfwklyn52wijb4vbimarn4ecy #hdf5%gcc@9.3.0
spack load intel-mkl%gcc@9.3.0
spack load /mfyqn4o3xnn2lw2l3tpmem6hw6omqlrv #hypre%gcc@9.3.0
spack load cmake%gcc@9.3.0
spack load parallel%gcc@9.3.0
#export IOMP=/home/sshirz1/src/spack/opt/spack/linux-rhel7-cascadelake/gcc-9.3.0/intel-mkl-2020.4.304-ytc7rlg22tx4ng2ss4wu3v5bd7ypkbce/compilers_and_libraries_2020.4.304/linux/compiler/lib/intel64_lin/
export CPATH=$CPATH:$HOME/src/spack/opt/spack/linux-rhel7-cascadelake/gcc-9.3.0/metis-5.1.0-2sk2zaevz7q4dq42xfsr6o5ediktxctm/include/
#export PATH=/home/sshirz1/src/spack/opt/spack/linux-rhel7-cascadelake/gcc-9.3.0/intel-mkl-2020.4.304-ytc7rlg22tx4ng2ss4wu3v5bd7ypkbce/compilers_and_libraries_2020.4.304/linux/compiler/lib/intel64_lin/:$PATH
#export LD_LIBRARY_PATH=/home/sshirz1/src/spack/opt/spack/linux-rhel7-cascadelake/gcc-9.3.0/intel-mkl-2020.4.304-ytc7rlg22tx4ng2ss4wu3v5bd7ypkbce/compilers_and_libraries_2020.4.304/linux/compiler/lib/intel64_lin/:$LD_LIBRARY_PATH
#
#cmake -DHYPRE_LIBRARY=$HOME/src/spack/opt/spack/linux-rhel7-cascadelake/gcc-9.3.0/hypre-2.23.0-2g7ahda6fkfpm6ggrdji7cj7g7kyp626/lib/libHYPRE.so -DCMAKE_CXX_FLAGS=-march=native ..

