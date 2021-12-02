source $HOME/src/spack/share/spack/setup-env.sh
spack load googletest%gcc@11.2.1
spack load openmpi%gcc@11.2.1
spack load parmetis%gcc@11.2.1
spack load clhep%gcc@11.2.1
spack load intel-mkl%gcc@11.2.1
spack load cmake%gcc@11.2.1

spack load /ew5bsawia6jd66bykkqnenh745cdqhwt 
spack load /7av5imakhj4ofvbznctym6iwrq7lek27

spack load cmake%gcc@11.2.1

export CPATH=$CPATH:~/src/spack/opt/spack/linux-fedora34-haswell/gcc-11.2.1/metis-5.1.0-hapeftff2enyvt335xp5mwryzsom6lhm/include/

#cmake -DHYPRE_LIBRARY=~/src/spack/opt/spack/linux-fedora34-haswell/gcc-11.2.1/hypre-2.23.0-ryeaoapuj6tayylmbheeect6ssi5no7d/lib/libHYPRE.so -DCMAKE_CXX_FLAGS=-march=native ..
