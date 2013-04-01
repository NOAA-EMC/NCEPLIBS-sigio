## Put version control id tag in output configure script
AC_REVISION($Id$)

## Initialise autoconf
AC_INIT([sigio], [v1.1.0-beta], [ncep.list.emc.nceplibs.support@noaa.gov])

# Output info for user
AC_MSG_NOTICE([sigio AC_PACKAGE_VERSION])

# Check for existence of unique file before proceeding
AC_CONFIG_SRCDIR([libsrc/sigio_module.f])

# Define the configuration files
AC_CONFIG_FILES([Makefile libsrc/Makefile])

# Check for programs
AC_PROG_FC(ifort gfortran xlf2003 pgf95)
AC_PROG_INSTALL

# Set the programming language
AC_LANG(Fortran)
AC_FC_FREEFORM
AC_FC_SRCEXT(f)

AC_OUTPUT
