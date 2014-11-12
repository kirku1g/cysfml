cimport config
cimport csystem


# Vector2
################################################################################


# Vector2i

cpdef csystem.Vector2i Vector2i(int x, int y)
cpdef tuple Vector2i_unpack(csystem.Vector2i vector)
cpdef csystem.Vector2i Vector2i_cast(value)
cpdef csystem.Vector2u Vector2u(unsigned int x, unsigned int y)
cpdef tuple Vector2u_unpack(csystem.Vector2u vector)
cpdef csystem.Vector2u Vector2u_cast(value)


# Vector2f

cpdef csystem.Vector2f Vector2f(float x, float y)
cpdef tuple Vector2f_unpack(csystem.Vector2f vector)
cpdef csystem.Vector2f Vector2f_cast(value)


# Vector3
################################################################################

cpdef csystem.Vector3f Vector3f(float x, float y, float z)
cpdef tuple Vector3f_unpack(csystem.Vector3f vector)
cpdef csystem.Vector3f Vector3f_cast(value)


# Time
################################################################################

cdef class Time:
    cdef csystem.Time Time
    
    cpdef float as_seconds(Time self)
    cpdef config.Int32 as_milliseconds(Time self)
    cpdef config.Int64 as_microseconds(Time self)


cdef Time Time_from_seconds(float amount)
cdef Time Time_from_milliseconds(config.Int32 amount)
cdef Time Time_from_microseconds(config.Int64 amount)


# Clock
#################################################################################

cdef ClockWrapper Clock_create()
cdef ClockWrapper Clock_wrap_ptr(csystem.Clock* clock_ptr)


cdef class ClockWrapper:
    '''
    Class which wraps a csystem.Clock pointer. Use Clock, Clock_create or Clock_wrap_ptr in preference.
    '''
    cdef csystem.Clock* Clock
    
    cpdef destroy(ClockWrapper self)
    cpdef ClockWrapper copy(ClockWrapper self)
    cpdef Time restart(ClockWrapper self)
    # elapsed_time
    cpdef Time get_elapsed_time(ClockWrapper self)
    # elapsed_seconds
    cpdef float get_elapsed_seconds(ClockWrapper self)
    # elapsed_milliseconds
    cpdef int get_elapsed_milliseconds(ClockWrapper self)
    # elapsed_microseconds
    cpdef long get_elapsed_microseconds(ClockWrapper self)


cdef class Clock(ClockWrapper):
    pass


# Sleep
################################################################################

cpdef sleep(Time duration)
cpdef sleep_seconds(float duration)
cpdef sleep_milliseconds(config.Int32 duration)
cpdef sleep_microseconds(config.Int64 duration)


# Mutex
################################################################################

cdef Mutex Mutex_create()
cdef Mutex Mutex_wrap_ptr(csystem.Mutex* mutex_ptr)


cdef class MutexWrapper:
    cdef csystem.Mutex* Mutex
    
    cpdef destroy(MutexWrapper self)
    cpdef lock(MutexWrapper self)
    cpdef unlock(MutexWrapper self)


cdef class Mutex(MutexWrapper):
    pass


# InputStream
################################################################################

cdef InputStream InputStream_wrap_ptr(csystem.InputStream* input_stream_ptr)


cdef class InputStream:
    cdef csystem.InputStream* InputStream


# Thread
################################################################################

# TODO
#cdef Thread create_thread_from_function_ptr(void (*function)(void*), void* user_data)
    #return wrap_thread_ptr(csystem.thread_create(function, user_data))


cdef Thread Thread_wrap_ptr(csystem.Thread* thread_ptr)


cdef class Thread:
    cdef csystem.Thread* Thread
    
    cpdef destroy(Thread self)
    cpdef launch(Thread self)
    cpdef wait(Thread self)
    cpdef terminate(Thread self)

