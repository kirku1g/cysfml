cimport config


# SFML/System/Types.h
################################################################################

cdef extern from 'SFML/System/Types.h' nogil:
    ctypedef struct Clock 'sfClock'
    ctypedef struct Mutex 'sfMutex'
    ctypedef struct Thread 'sfThread'


# SFML/System/Time.h
################################################################################

cdef extern from 'SFML/System/Time.h' nogil:
    ctypedef struct Time 'sfTime':
        config.Int64 microseconds
    
    cdef Time TIME_ZERO 'sfTime_Zero'
    
    cdef float Time_as_seconds 'sfTime_asSeconds' (Time time)
    cdef config.Int32 Time_as_milliseconds 'sfTime_asMilliseconds' (Time time)
    cdef config.Int64 Time_as_microseconds 'sfTime_asMicroseconds' (Time time)
    cdef Time seconds 'sfSeconds' (float amount)
    cdef Time milliseconds 'sfMilliseconds' (config.Int32 amount)
    cdef Time microseconds 'sfMicroseconds' (config.Int64 amount)


# SFML/System/Clock.h
################################################################################

cdef extern from 'SFML/System/Clock.h' nogil:
    cdef Clock* Clock_create 'sfClock_create' ()
    cdef Clock* Clock_copy 'sfClock_copy' (Clock* clock)
    cdef void Clock_destroy 'sfClock_destroy' (Clock* clock)
    cdef Time Clock_get_elapsed_time 'sfClock_getElapsedTime'(const Clock* clock)
    cdef Time Clock_restart 'sfClock_restart' (Clock* clock)


# SFML/System/Sleep.h
################################################################################

cdef extern from 'SFML/System/Time.h' nogil:
    cdef void sleep 'sfSleep' (Time duration)


# SFML/System/Vector2.h
################################################################################

cdef extern from 'SFML/System/Vector2.h' nogil:
    ctypedef struct Vector2i 'sfVector2i':
        int x
        int y
    
    ctypedef struct Vector2u 'sfVector2u':
        unsigned int x
        unsigned int y
    
    ctypedef struct Vector2f 'sfVector2f':
        float x
        float y


# SFML/System/Vector3.h
################################################################################

cdef extern from 'SFML/System/Vector3.h' nogil:
    ctypedef struct Vector3f 'sfVector3f':
        float x
        float y
        float z


# SFML/System/Mutex.h
################################################################################

cdef extern from 'SFML/System/Mutex.h' nogil:
    cdef Mutex* Mutex_create 'sfMutex_create' ()
    cdef void Mutex_destroy 'sfMutex_destroy' (Mutex *mutex)
    cdef void Mutex_lock 'sfMutex_lock' (Mutex *mutex)
    cdef void Mutex_unlock 'sfMutex_unlock' (Mutex *mutex)


# SFML/System/InputStream.h
################################################################################

cdef extern from 'SFML/System/InputStream.h' nogil:
    ctypedef config.Int64 (*InputStreamReadFunc 'sfInputStreamReadFunc')(void* data, config.Int64 size, void* userData)
    ctypedef config.Int64 (*InputStreamSeekFunc 'sfInputStreamSeekFunc')(config.Int64 position, void* userData)
    ctypedef config.Int64 (*InputStreamTellFunc 'sfInputStreamTellFunc')(void* userData)
    ctypedef config.Int64 (*InputStreamGetSizeFunc 'sfInputStreamGetSizeFunc')(void* userData)
    
    ctypedef struct InputStream 'sfInputStream':
        InputStreamReadFunc read
        InputStreamSeekFunc seek
        InputStreamTellFunc tell
        InputStreamGetSizeFunc get_size 'getSize'
        void* user_data 'userData'


# SFML/System/Thread.h
################################################################################

cdef extern from 'SFML/System/Thread.h' nogil:
    cdef Thread* Thread_create 'sfThread_create' (void (*function)(void*), void* userData)
    cdef void Thread_destroy 'sfThread_destroy' (Thread* thread)
    cdef void Thread_launch 'sfThread_launch' (Thread* thread)
    cdef void Thread_wait 'sfThread_wait' (Thread* thread)
    cdef void Thread_terminate 'sfThread_terminate' (Thread* thread)

