# *** manually set environments (for gnu compiler) of sigio ***

# !!! module environment (*THEIA*) !!!
#module load gcc/6.2.0   # use default GCC comiler for compatible to w3emc

 ANCHORDIR=..
 export COMP=gnu
 export SIGIO_VER=v2.0.1
 export SIGIO_SRC=
 export SIGIO_INC4=$ANCHORDIR/include/sigio_${SIGIO_VER}_4
 export SIGIO_LIB4=$ANCHORDIR/libsigio_${SIGIO_VER}_4.a

 export CC=gcc
 export FC=gfortran
 export CPP=cpp
 export OMPCC="$CC -fopenmp"
 export OMPFC="$FC -fopenmp"
 export MPICC=mpigcc
 export MPIFC=mpigfortran

 export DEBUG="-g -O0"
 export CFLAGS="-O3 -DUNDERSCORE -DLINUX -fPIC"
 export FFLAGS="-O3 -fPIC"
 export CPPFLAGS="-P -traditional-cpp"
 export MPICFLAGS="-O3 -DUNDERSCORE -DLINUX -fPIC"
 export MPIFFLAGS="-O3 -fPIC"
 export MODPATH="-J"
 export I4R4=""
 export I4R8="-fdefault-real-8"
 export I8R8="-fdefault-integer-8 -fdefault-real-8"

 export CPPDEFS=""
 export CFLAGSDEFS=""
 export FFLAGSDEFS="-ffree-form -fconvert=big-endian -fimplicit-none -fno-second-underscore -frecord-marker=4 -funroll-loops -Wall"

 export USECC=""
 export USEFC="YES"
 export DEPS=""
