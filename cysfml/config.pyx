cimport cysfml.config

#cdef extern from 'SFML/Config.h':
    ## portable boolean type
    #ctypedef sfBool
    #cdef int sfFalse
    #cdef int sfTrue
    ## 8 bits integer types
    #ctypedef signed char sfInt8
    #ctypedef unsigned char sfUint8
    ## 16 bits integer types
    #ctypedef signed short sfInt16
    #ctypedef unsigned short sfUint16
    ## 32 bits integer types
    #ctypedef signed int sfInt32
    #ctypedef unsigned int sfUint32
    ## 64 bits integer types (TODO: _MSC_VER)
    #ctypedef signed long long sfInt64
    #ctypedef unsigned long long sfUint64
    