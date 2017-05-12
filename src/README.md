Instructions for editing the hdf5 source down into a reduced version for inclusion the package.  The is just a record of the steps I took, and should be automated in the future if possible.

### Deleted the following folders:
  - /examples
  - /fortran
  - /hl
  - /java
  - /release_docs
  - /test
  - /testpar
  - /tools
  - /c++/examples
  - /c++/test

### Modified */configure.ac*

- Remove references to the deleted files.  Replace lines 3355 - 3472 with

```
AC_CONFIG_FILES([src/libhdf5.settings
                 Makefile
                 src/Makefile
                 c++/Makefile
                 c++/src/Makefile
                 c++/src/h5c++])
```
- Comment out lines 3371 - 3379

```
#chmod 755 tools/src/misc/h5cc
#
#if test "X$HDF_FORTRAN" = "Xyes"; then
#  chmod 755 fortran/src/h5fc
#fi
```
- Comment out reference to *fortran/src/H5config_f.inc* on lines 464 & 465

Then run `autoconf` in `/`.

### Modified */c++/Makefile.am*

- Remove references to *test* and *examples* folders on lines 23 and 25 e.g.

```
if BUILD_CXX_CONDITIONAL
   SUBDIRS=src
endif
DIST_SUBDIRS = src
```

### Modified */Makefile.am*

- Remove references to multiple folders that no longer exist on lines 78 - 80 e.g.

```
SUBDIRS = src . $(CXX_DIR)
DIST_SUBDIRS = src . c++
```

- Comment out lines for building the tests, lines 99 - 105.

```
# Make all, tests, and (un)install
#tests:
#	for d in $(SUBDIRS); do                        \
#	  if test $$d != .; then                                        \
#	   (cd $$d && $(MAKE) $(AM_MAKEFLAGS) $@) || exit 1;            \
#	  fi;                                                           \
#	  done
```
run `automake` in `/`
