# Process this file with autoconf to produce a configure script.
# author: Mike Smith (mike.smith@embl.de)

AC_PREREQ([2.65])
AC_INIT([Rhdf5lib], [0.0.1], [mike.smith@embl.de])
AC_CONFIG_SRCDIR([src/H5.c])

# Check the compiler configured with R
: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
  echo "could not determine R_HOME"
  exit 1
fi

CC=`"${R_HOME}/bin/R" CMD config CC`
CFLAGS=`"${R_HOME}/bin/R" CMD config CFLAGS`
MAKE=`${R_HOME}/bin/R CMD config MAKE`
CXX="${CXX}"
CXXFLAGS=`"${R_HOME}/bin/R" CMD config CXXFLAGS`
F77=`"${R_HOME}/bin/R" CMD config F77`
AC_LANG(C++)

# Checks for programs.
AC_PROG_CC
AC_PROG_CXX

#untar the lib
BASEPBNAME="hdf5"
PBTGZNAME=hdf5/hdf5small_cxx.tgz
cd src
if test -d ./${BASEPBNAME}; then 
	echo 'found ' $BASEPBNAME ' header sources and tar archive;using what is there.'
else
	echo "untarring hdf5small.tgz ...";
	gunzip -dc ${PBTGZNAME} | tar xf -;
fi;

echo "building the bundled hdf5 library...";
cd ${BASEPBNAME};
./configure  --with-pic --enable-shared=no --enable-cxx \
    CXX="${CXX}" CXXFLAGS="${CXXFLAGS}" CC="${CC}" CFLAGS="${CFLAGS}" F77="${F77}"
$MAKE lib
cd ../../

#update variables in Makevars
HDF5_INCLUDE="${BASEPBNAME}/src"
AC_SUBST(HDF5_INCLUDE)
AC_MSG_NOTICE([   HDF5_INCLUDE=${HDF5_INCLUDE}])

HDF5_LIB="${BASEPBNAME}/src/.libs/libhdf5.a"
AC_SUBST(HDF5_LIB)
AC_MSG_NOTICE([   HDF5_LIB=${HDF5_LIB}])
AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT
