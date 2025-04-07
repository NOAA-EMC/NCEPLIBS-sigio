@mainpage

# NCEPLIBS-sigio

This library provides an Application Program Interface for performing
I/O on the sigma restart file of the global spectral model. Functions
include opening, reading, writing, and closing as well as allocating
and deallocating data buffers used in the transfers. The I/O performed
here is sequential. The transfers are limited to header records or
data records.

This is part of the [NCEPLIBS](https://github.com/NOAA-EMC/NCEPLIBS)
project.

## Installation

```
git clone https://github.com/NOAA-EMC/NCEPLIBS-sigio # or download a release from https://github.com/NOAA-EMC/NCEPLIBS-sigio/releases
cmake -DCMAKE_INSTALL_PREFIX=/path/to/install -S NCEPLIBS-sigio -B NCEPLIBS-sigio/build # <add'l CMake options>
cmake --build NCEPLIBS-sigio/build --parallel 2
ctest --test-dir NCEPLIBS-sigio/build --parallel 2 # <add'l CTest options>
cmake --install NCEPLIBS-sigio/build
```

The following CMake build options can be used to configure the build by setting them with `-D<OPTION>=<VALUE>`.

| Option | Description | Default |
|--------|-------------|---------|
| CMAKE_INSTALL_PREFIX | Installation path | /usr/local |
| CMAKE_POSITION_INDEPENDENT_CODE | Enable position-independent code (PIC) for static build | OFF |
| ENABLE_DOCS | Enable generation of doxygen-based documentation. | OFF |
