cdef class Example:
    cdef:
        public bint benchmark
    
    cpdef _run(Example self)
    cpdef run(Example self)
    cpdef sleep(Example self, float seconds)
    cpdef output(Example self, basestring message)

cpdef Example example_from_args(dict classes)