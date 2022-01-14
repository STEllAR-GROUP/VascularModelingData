#!/bin/bash
source ~/src/spack/share/spack/setup-env.sh
spack install googletest
spack install mpich
spack install hdf5+mpi ^mpich   
spack install metis 
spack install parmetis ^mpich
spack install clhep
spack install intel-mkl
spack install hypre ^mpich     


