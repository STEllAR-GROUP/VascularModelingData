source $HOME/src/spack/share/spack/setup-env.sh

module load intel/2021
export PATH=$PATH:/opt/intel/oneapi/compiler/2021.3.0/linux/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/oneapi/compiler/2021.3.0/linux/compiler/lib
export CPATH=$CPATH:/opt/intel/oneapi/compiler/2021.3.0/linux/compiler/include
export CC=/opt/intel/oneapi/compiler/2021.3.0/linux/bin/intel64/icc
export CXX=/opt/intel/oneapi/compiler/2021.3.0/linux/bin/intel64/icpc
export F77=/opt/intel/oneapi/compiler/2021.3.0/linux/bin/intel64/ifort
export FC=/opt/intel/oneapi/compiler/2021.3.0/linux/bin/intel64/ifort
export IPPROOT=/opt/intel/oneapi/ipp/2021.3.0/

module load mkl
spack load googletest%oneapi@2021.3.0
spack load mpich%oneapi@2021.3.0
spack load parmetis%oneapi@2021.3.0
spack load clhep%oneapi@2021.3.0
spack load hdf5%oneapi@2021.3.0
#spack load intel-mkl%oneapi@2021.3.0
spack load hypre%oneapi@2021.3.0
spack load cmake %oneapi@2021.3.0

export CPATH=$CPATH:/home/sshirzad/src/spack/opt/spack/linux-centos8-skylake_avx512/oneapi-2021.3.0/metis-5.1.0-wvs2h774lch2st7ci2div4qwncj2z5rs/include/

#cmake -DHYPRE_LIBRARY=/home/sshirzad/src/spack/opt/spack/linux-centos8-skylake_avx512/oneapi-2021.3.0/hypre-2.22.0-z7krpe4r55mihlmckjtyaxoipnfvdykc/lib/libHYPRE.so ..
