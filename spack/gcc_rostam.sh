module load gcc

source $HOME/src/spack/share/spack/setup-env.sh
spack load googletest%gcc@10.2.0
spack load mpich%gcc@10.2.0
spack load parmetis%gcc@10.2.0
spack load clhep%gcc@10.2.0
spack load hdf5%gcc@10.2.0
spack load intel-mkl%gcc@10.2.0
spack load hypre%gcc@10.2.0
spack load cmake%gcc@10.2.0

export CPATH=$CPATH:/home/sshirzad/src/spack/opt/spack/linux-centos8-skylake_avx512/gcc-10.2.0/metis-5.1.0-7thcp5alozyxvaakodlplxnctj4plfug/include/

#cmake -DHYPRE_LIBRARY=/home/sshirzad/src/spack/opt/spack/linux-centos8-skylake_avx512/gcc-10.2.0/hypre-2.22.0-bhs3ecjulvffdnz77sz3xuhohb5rbw3l/lib/libHYPRE.so -DCMAKE_CXX_FLAGS=-march=native ..
