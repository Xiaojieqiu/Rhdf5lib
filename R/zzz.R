pkgconfig <- function(opt = c("PKG_LIBS", "PKG_CPPFLAGS")) {
    path <- system.file("lib", package="Rhdf5lib", mustWork=TRUE)
    if (nzchar(.Platform$r_arch)) {
        arch <- sprintf("/%s", .Platform$r_arch)
    } else {
        arch <- ""
    }
    patharch <- paste0(path, arch)
    
    result <- switch(match.arg(opt), 
                     PKG_CPPFLAGS = {
                         sprintf('-I"%s"', system.file("include", package="Rhdf5lib"))
                     }, 
                     PKG_LIBS = {
                         switch(Sys.info()['sysname'], 
                                Linux={
                                    sprintf('-L%s -lhdf5_cpp -lhdf5 -ldl -lz',
                                            patharch)
                                }#, Darwin={
                                #    sprintf('%s/libhts.a -lz -pthread', patharch)
                                #}, 
                                Windows={
                                    sprintf('-L"%s" -lhdf5_cpp -lhdf5 -ldl -lz', patharch)
                                }
                         )
                     }
    )
    
    cat(result)
}
