#!/bin/sh
###############################################################################
#
# $Id$
#
# Script to configure, build, and install the library.
#
# The build configuration setup (compiler, compiler switched, libraries, etc)
# is specified via files in the config-setup/ subdirectory that are sourced
# within this script.
#
# The installation directory is ${PWD}
#
###############################################################################

# Check that a build setup file was specified.
if [ $# -ne 1 ]; then
  echo "$0: Must specify build setup. Valid setups:" >&2
  echo "Usage: `basename $0` setup-file" >&2
  echo "  Valid setups:" >&2
  for FILE in `ls ./config-setup/*.setup`; do
    echo "    `basename ${FILE} .setup`" >&2
  done
  exit 1
fi


# Source the build setup
SETUP_FILE="./config-setup/$1.setup"
if [ ! -f ${SETUP_FILE} ]; then
  echo "$0: Cannot find specified setup file ${SETUP_FILE}" >&2
  exit 1
fi
. ${SETUP_FILE}


# Generate the makefiles
echo; echo; echo; echo
echo "==============================================================="
echo "==============================================================="
echo "Configuring for build"
echo "==============================================================="
echo "==============================================================="
echo
./configure --prefix=${PWD}
if [ $? -ne 0 ]; then
  echo "$0: Error configuring for build" >&2
  exit 1
fi

# Build the current configuration
echo; echo
echo "==============================================================="
echo "Starting build"
echo "==============================================================="
echo
make clean
make
if [ $? -ne 0 ]; then
  echo "$0: Error building" >&2
  exit 1
fi

# Install the current build...
echo; echo
echo "==============================================================="
echo "Performing GNU-type install of build"
echo "==============================================================="
echo
make install

echo; echo
echo "==============================================================="
echo "Performing NCO-type install of build"
echo "==============================================================="
echo
make nco_install

