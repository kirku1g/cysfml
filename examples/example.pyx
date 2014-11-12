from system cimport (
    Clock,
    Clock_create,
    sleep_seconds,
)


cdef class Example:
    def __init__(self, bint benchmark=False):
        self.benchmark = benchmark
    
    cpdef _run(self):
        return
    
    cpdef run(self):
        cdef Clock clock
        if self.benchmark:
            clock = Clock_create()
        self._run()
        if self.benchmark:
            self.output('Benchmark: %f' % clock.get_elapsed_seconds())
    
    cpdef sleep(self, float seconds):
        if not self.benchmark:
            sleep_seconds(seconds)
    
    cpdef output(self, basestring message):
        if not self.benchmark:
            print(message)


cpdef Example example_from_args(dict classes):
    from argparse import ArgumentParser
    parser = ArgumentParser()
    
    parser.add_argument('implementation')
    parser.add_argument('-b', '--benchmark', action='store_true')
    
    args = parser.parse_args()
    
    try:
        cls = classes[args.implementation]
    except KeyError:
        parser.error('Unknown implementation %s, choose one of: %s' % 
                     (args.implementation, ', '.join(cls.keys())))
        from sys import exit
        exit(1)
    
    return cls(benchmark=args.benchmark)