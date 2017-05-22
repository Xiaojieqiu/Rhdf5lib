pkgconfig <- function(opt = c("PKG_CXX_LIBS", "PKG_C_LIBS","PKG_CPPFLAGS")) {
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
                     PKG_C_LIBS = {
                         switch(Sys.info()['sysname'], 
                                Linux = {
                                    sprintf('%s/libhdf5.a',
                                            patharch)
                                }, Darwin = {
                                    sprintf('%s/libhdf5.a', 
                                            patharch)
                                }, Windows = {
                                    sprintf('-L%s -lhdf5 -lz -lws2_32 -ldl -lm -lpsapi', 
                                            patharch)
                                }
                         )
                     }, 
                     PKG_CXX_LIBS = {
                         switch(Sys.info()['sysname'], 
                                Linux = {
                                    sprintf('%s/libhdf5_cpp.a %s/libhdf5.a',
                                            patharch, patharch)
                                }, Darwin = {
                                    sprintf('%s/libhdf5_cpp.a %s/libhdf5.a', 
                                            patharch, patharch)
                                }, Windows = {
                                    sprintf('-L%s -lhdf5_cpp -lhdf5 -lz -lws2_32 -ldl -lm -lpsapi', 
                                            patharch)
                                }
                         )
                     }
    )
    
    cat(result)
}
