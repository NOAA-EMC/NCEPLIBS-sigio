Utilities to handle SIGIO files
---

- `ss2gg.f90` is a utility that reads in the spectral coefficients and writes out a binary file of gridded data at the sigma levels
- `ss2lv.f90` is a utility that reads in the spectral coefficients and writes out gridded binary at requested levels
- `sigdif.f90` is a utility to diff two spectral files and write out the difference.

These utilities were used with the GFS spectral model and are provided here as a place holder for historical purposes.  They are not unsupported and out of use since the GFS switched to nemsio output.
