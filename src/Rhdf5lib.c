/* do not remove */

#include <Rdefines.h>
#include <R_ext/Error.h>
#include "hdf5/src/hdf5.h"

SEXP Rhdf5lib_hdf5_libversion(void)
{
    unsigned majnum;
    unsigned minnum;
    unsigned relnum;
    herr_t herr = H5get_libversion( &majnum, &minnum, &relnum );
    
    SEXP Rval;
    if (herr < 0) {
        error("Failed reading HDF5 library version.");
        PROTECT(Rval = allocVector(INTSXP, 1));
        INTEGER(Rval)[0] = herr;
        UNPROTECT(1);
    } else {
        PROTECT(Rval = allocVector(INTSXP, 3));
        INTEGER(Rval)[0] = majnum;
        INTEGER(Rval)[1] = minnum;
        INTEGER(Rval)[2] = relnum;
        
        SEXP names = PROTECT(allocVector(STRSXP,3));
        SET_STRING_ELT(names, 0, mkChar("majnum"));
        SET_STRING_ELT(names, 1, mkChar("minnum"));
        SET_STRING_ELT(names, 2, mkChar("relnum"));
        SET_NAMES(Rval, names);
        UNPROTECT(1);
        
        UNPROTECT(1);
    }
    return Rval;
}
