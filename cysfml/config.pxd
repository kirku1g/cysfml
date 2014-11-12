

cdef extern from 'SFML/Config.h':
    # portable boolean type
    ctypedef int Bool 'sfBool' # bint is used instead
    cdef int FALSE 'sfFalse'
    cdef int TRUE 'sfTrue'
    # 8 bits integer types
    ctypedef signed char Int8 'sfInt8'
    ctypedef unsigned char Uint8 'sfUint8'
    # 16 bits integer types
    ctypedef signed short Int16 'sfInt16'
    ctypedef unsigned short Uint16 'sfUint16'
    # 32 bits integer types
    ctypedef signed int Int32 'sfInt32'
    ctypedef unsigned int Uint32 'sfUint32'
    # 64 bits integer types (TODO: _MSC_VER)
    ctypedef signed long long Int64 'sfInt64'
    ctypedef unsigned long long Uint64 'sfUint64'
    