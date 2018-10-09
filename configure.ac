## Put version control id tag in output configure script
AC_REVISION($Id: configure.ac 43497 2014-07-28 13:34:36Z fanglin.yang@noaa.gov $)


## Initialise autoconf
AC_INIT([nceplibs sigio], [v2.0.1], [ncep.list.emc.nceplibs.support@noaa.gov], [sigio])


# Output info for user
AC_MSG_NOTICE([AC_PACKAGE_NAME AC_PACKAGE_VERSION])


# Check for existence of unique file before proceeding
AC_CONFIG_SRCDIR([libsrc/sigio_module.f])


# Define the configuration files
AC_CONFIG_FILES([Makefile libsrc/Makefile])


# Check for programs
AC_PROG_FC(ifort gfortran xlf2003 pgf95)
AC_PROG_INSTALL
AC_CHECK_TOOL([AR], ar)
AC_CHECK_TOOL([RANLIB], ranlib)
# ...Set defaults for ARFLAGS since there is no autoconf macro
test -n "$ARFLAGS" || ARFLAGS="crvs"
AC_SUBST(ARFLAGS)


# Set the programming language
AC_LANG(Fortran)
AC_FC_FREEFORM
AC_FC_SRCEXT(f)

AC_OUTPUT
