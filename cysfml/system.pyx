cimport config
cimport csystem
cimport utils


# Vector2
################################################################################


# Vector2i

cpdef csystem.Vector2i Vector2i(int x, int y):
    '''
    Creates a csystem.Vector2i struct from x and y values.
    '''
    cdef csystem.Vector2i vector
    vector.x = x
    vector.y = y
    return vector


cpdef tuple Vector2i_unpack(csystem.Vector2i vector):
    '''
    Unpacks a csystem.Vector2i struct into a tuple containing x and y.
    '''
    return vector.x, vector.y


cpdef csystem.Vector2i Vector2i_cast(value):
    '''
    Casts the following into a csystem.Vector2i struct:
     - tuple containing x and y.
     - list containing x and y.
     - dict containing x and y keys.
     - csystem.Vector2i struct (unchanged).
    '''
    return Vector2i(value[0], value[1]) if utils.is_iterable(value) else value


# Vector2u

cpdef csystem.Vector2u Vector2u(unsigned int x, unsigned int y):
    '''
    Creates a csystem.Vector2u struct from x and y values.
    '''
    cdef csystem.Vector2u vector
    vector.x = x
    vector.y = y
    return vector


cpdef tuple Vector2u_unpack(csystem.Vector2u vector):
    '''
    Unpacks a csystem.Vector2u struct into a tuple containing x and y.
    '''
    return vector.x, vector.y


cpdef csystem.Vector2u Vector2u_cast(value):
    '''
    Casts the following into a csystem.Vector2u struct:
     - tuple containing x and y.
     - list containing x and y.
     - dict containing x and y keys.
     - csystem.Vector2u struct (unchanged).
    '''
    return Vector2i(value[0], value[1]) if utils.is_iterable(value) else value


# Vector2f

cpdef csystem.Vector2f Vector2f(float x, float y):
    '''
    Creates a csystem.Vector2f struct from x and y values.
    '''
    cdef csystem.Vector2f vector
    vector.x = x
    vector.y = y
    return vector


cpdef tuple Vector2f_unpack(csystem.Vector2f vector):
    '''
    Unpacks a csystem.Vector2u struct into a tuple containing x and y.
    '''
    return vector.x, vector.y


cpdef csystem.Vector2f Vector2f_cast(value):
    '''
    Casts the following into a csystem.Vector2f struct:
     - tuple containing x and y.
     - list containing x and y.
     - dict containing x and y keys.
     - csystem.Vector2f struct (unchanged).
    '''
    return Vector2f(value[0], value[1]) if utils.is_iterable(value) else value


# Vector3
################################################################################

cpdef csystem.Vector3f Vector3f(float x, float y, float z):
    '''
    Creates a csystem.Vector3f struct from x, y and z values.
    '''
    cdef csystem.Vector3f vector
    vector.x = x
    vector.y = y
    vector.z = z
    return vector


cpdef tuple Vector3f_unpack(csystem.Vector3f vector):
    '''
    Unpacks a csystem.Vector3f struct into a tuple containing x, y and z.
    '''
    return vector.x, vector.y, vector.z


cpdef csystem.Vector3f Vector3f_cast(value):
    '''
    Casts the following into a csystem.Vector3f struct:
     - tuple containing x, y and z.
     - list containing x, y and z.
     - dict containing x, y and z keys.
     - csystem.Vector3f struct (unchanged).
    '''
    return Vector3f(*value) if utils.is_iterable(value) else value


# Time
################################################################################

cdef class Time:
    '''
    Class which wraps a csystem.Time struct.
    '''
    def __cinit__(Time self, csystem.Time Time):
        self.Time = Time
    
    # seconds
    
    cpdef float as_seconds(Time self):
        return csystem.Time_as_seconds(self.Time)
    
    property seconds:
        '''
        Time in seconds.
        '''
        def __get__(Time self):
            return csystem.Time_as_seconds(self.Time)
    
    # milliseconds
    
    cpdef config.Int32 as_milliseconds(Time self):
        return csystem.Time_as_milliseconds(self.Time)
    
    property milliseconds:
        '''
        Time in milliseconds.
        '''
        def __get__(Time self):
            return csystem.Time_as_milliseconds(self.Time)
    
    # microseconds
    
    cpdef config.Int64 as_microseconds(Time self):
        return csystem.Time_as_microseconds(self.Time)
    
    property microseconds:
        '''
        Time in microseconds.
        '''
        def __get__(Time self):
            return csystem.Time_as_microseconds(self.Time)
    
    # Python constructors
    
    @staticmethod
    def from_seconds(float amount):
        return Time(csystem.seconds(amount))
    
    @staticmethod
    def from_milliseconds(config.Int32 amount):
        return Time(csystem.milliseconds(amount))
    
    @staticmethod
    def from_microseconds(config.Int64 amount):
        return Time(csystem.microseconds(amount))
    
    # Special methods
    
    def __str__(Time self):
        return '%.3fs' % self.as_seconds()
    
    def __repr__(Time self):
        return 'cysfml.Time.Time_from_microseconds(%f)' % self.as_microseconds()
    
    def __int__(Time self):
        '''
        long and int types have been unified in Python 3, therefore return more accurate precision.
        '''
        return self.as_microseconds()
    
    def __float__(Time self):
        return self.as_seconds()
    
    def __richcmp__(Time self, other, int op):
        if not isinstance(other, Time):
            return False
        
        return utils.richcmp_floats(
            self.as_seconds(),
            other.as_seconds(),
            op,
        )


cdef Time Time_from_seconds(float amount):
    return Time(csystem.seconds(amount))


cdef Time Time_from_milliseconds(config.Int32 amount):
    return Time(csystem.milliseconds(amount))


cdef Time Time_from_microseconds(config.Int64 amount):
    return Time(csystem.microseconds(amount))


# Clock
#################################################################################


cdef class ClockWrapper:
    '''
    Class which wraps a csystem.Clock pointer. Use Clock, Clock_create or Clock_wrap_ptr in preference.
    '''
    
    # Cython methods
    
    cpdef destroy(ClockWrapper self):
        if self.Clock:
            csystem.Clock_destroy(self.Clock)
            self.Clock = NULL
    
    cpdef ClockWrapper copy(ClockWrapper self):
        return Clock_wrap_ptr(csystem.Clock_copy(self.Clock))
    
    cpdef Time restart(ClockWrapper self):
        return Time(csystem.Clock_restart(self.Clock))
    
    # Attributes
    
    # elapsed_time
    
    cpdef Time get_elapsed_time(ClockWrapper self):
        return Time(csystem.Clock_get_elapsed_time(self.Clock))
    
    property elapsed_time:
        def __get__(ClockWrapper self):
            return self.get_elapsed_time()
    
    # elapsed_seconds
    
    cpdef float get_elapsed_seconds(ClockWrapper self):
        return csystem.Time_as_seconds(csystem.Clock_get_elapsed_time(self.Clock))
    
    property elapsed_seconds:
        def __get__(ClockWrapper self):
            return self.get_elapsed_seconds()
    
    # elapsed_milliseconds
    
    cpdef int get_elapsed_milliseconds(ClockWrapper self):
        return csystem.Time_as_milliseconds(csystem.Clock_get_elapsed_time(self.Clock))
    
    property elapsed_milliseconds:
        def __get__(ClockWrapper self):
            return self.get_elapsed_milliseconds()
    
    # elapsed_microseconds
    
    cpdef long get_elapsed_microseconds(ClockWrapper self):
        return csystem.Time_as_microseconds(csystem.Clock_get_elapsed_time(self.Clock))
    
    property elapsed_microseconds:
        def __get__(ClockWrapper self):
            return self.get_elapsed_microseconds()
    
    # Special methods
    
    def __dealloc__(ClockWrapper self):
        if self.Clock:
            csystem.Clock_destroy(self.Clock)
    
    def __repr__(ClockWrapper self):
        '''
        It is not possible to set the time of a clock.
        '''
        return 'Clock()'
    
    def __str__(ClockWrapper self):
        return 'Clock: %s' % self.get_elapsed_time()


cdef ClockWrapper Clock_wrap_ptr(csystem.Clock* clock_ptr):
    cdef ClockWrapper clock = ClockWrapper()
    clock.Clock = clock_ptr
    return clock


cdef ClockWrapper Clock_create():
    return Clock_wrap_ptr(csystem.Clock_create())


cdef class Clock(ClockWrapper):
    def __cinit__(Clock self):
        self.Clock = csystem.Clock_create()


# Sleep
################################################################################

cpdef sleep(Time duration):
    csystem.sleep(duration.Time)


cpdef sleep_seconds(float duration):
    csystem.sleep(csystem.seconds(duration))


cpdef sleep_milliseconds(config.Int32 duration):
    csystem.sleep(csystem.milliseconds(duration))


cpdef sleep_microseconds(config.Int64 duration):
    csystem.sleep(csystem.microseconds(duration))


# Mutex
################################################################################

cdef Mutex Mutex_create():
    return Mutex_wrap_ptr(csystem.Mutex_create())


cdef Mutex Mutex_wrap_ptr(csystem.Mutex* mutex_ptr):
    cdef Mutex mutex = MutexWrapper()
    mutex.Mutex = mutex_ptr
    return mutex


cdef class MutexWrapper:
    '''
    Class which wraps a csystem.Mutex pointer. Use Mutex, Mutex_create or Mutex_wrap_ptr in preference.
    '''
    
    # Cython methods
    
    cpdef destroy(MutexWrapper self):
        if self.Mutex:
            csystem.Mutex_destroy(self.Mutex)
            self.Mutex = NULL
    
    cpdef lock(MutexWrapper self):
        csystem.Mutex_lock(self.Mutex)
    
    cpdef unlock(MutexWrapper self):
        csystem.Mutex_unlock(self.Mutex)
    
    # Special methods
    
    def __dealloc__(MutexWrapper self):
        if self.Mutex:
            csystem.Mutex_destroy(self.Mutex)
    
    def __repr__(MutexWrapper self):
        return 'Mutex()'


cdef class Mutex(MutexWrapper):
    
    def __cinit__(Mutex self):
        self.Mutex = csystem.Mutex_create()


# InputStream
################################################################################

cdef InputStream InputStream_wrap_ptr(csystem.InputStream* input_stream_ptr):
    cdef InputStream input_stream = InputStream()
    input_stream.InputStream = input_stream_ptr
    return input_stream


cdef class InputStream:
    pass


# Thread
################################################################################

# TODO
#cdef Thread create_thread_from_function_ptr(void (*function)(void*), void* user_data):
    #return wrap_thread_ptr(csystem.thread_create(function, user_data))


cdef Thread Thread_wrap_ptr(csystem.Thread* thread_ptr):
    cdef Thread thread = Thread()
    thread.Thread = thread_ptr
    return thread


cdef class Thread:
    
    # Cython methods
    
    cpdef destroy(Thread self):
        if self.Thread:
            csystem.Thread_destroy(self.Thread)
            self.Thread = NULL
    
    cpdef launch(Thread self):
        csystem.Thread_launch(self.Thread)
    
    cpdef wait(Thread self):
        csystem.Thread_wait(self.Thread)
    
    cpdef terminate(Thread self):
        csystem.Thread_terminate(self.Thread)

