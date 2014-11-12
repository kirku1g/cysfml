from config cimport Int16

cimport csystem
cimport system

cimport caudio


# SFML/Audio/SoundStatus.h
################################################################################

SOUND_STATUS_STOPPED = caudio.SOUND_STATUS_STOPPED 
SOUND_STATUS_PAUSED = caudio.SOUND_STATUS_PAUSED
SOUND_STATUS_PLAYING = caudio.SOUND_STATUS_PLAYING


# SoundBuffer
################################################################################

cdef SamplesWrapper Samples_wrap_ptr(Int16* samples_ptr):
    cdef SamplesWrapper samples = SamplesWrapper()
    samples.Samples = samples_ptr
    return samples


cdef class SamplesWrapper:
    pass


cdef SoundBufferWrapper SoundBuffer_wrap_ptr(caudio.SoundBuffer* sound_buffer_ptr):
    cdef SoundBufferWrapper sound_buffer = SoundBufferWrapper()
    sound_buffer.SoundBuffer = sound_buffer_ptr
    return sound_buffer


cdef SoundBufferWrapper SoundBuffer_create_from_file(const char* filename):
    return SoundBuffer_wrap_ptr(caudio.SoundBuffer_create_from_file(filename))


cdef SoundBufferWrapper SoundBuffer_create_from_memory(const void* data, size_t size_in_bytes):
    return SoundBuffer_wrap_ptr(caudio.SoundBuffer_create_from_memory(data, size_in_bytes))


cdef class SoundBufferWrapper:
    '''
    SoundBuffer data must be destroyed/deallocated manually to avoid garbage collection rendering Sound objects unusable.
    '''
    
    # Python constructors
    
    @staticmethod
    def from_file(const char* filename):
        return SoundBuffer_wrap_ptr(caudio.SoundBuffer_create_from_file(filename))
    
    # Cython methods
    
    cpdef destroy(SoundBufferWrapper self):
        if self.SoundBuffer:
            caudio.SoundBuffer_destroy(self.SoundBuffer)
            self.SoundBuffer = NULL
    
    cpdef SoundBufferWrapper copy(SoundBufferWrapper self):
        return SoundBuffer_wrap_ptr(caudio.SoundBuffer_copy(self.SoundBuffer))
    
    cpdef save_to_file(SoundBufferWrapper self, const char* filename):
        if not caudio.SoundBuffer_save_to_file(self.SoundBuffer, filename):
            raise IOError('Saving SoundBuffer to file failed.')
    
    cdef const Int16* get_samples_array(SoundBufferWrapper self):
        return caudio.SoundBuffer_get_samples(self.SoundBuffer)
    
    # Special methods
    
    #def __dealloc__(SoundBufferWrapper self):
        #caudio.SoundBuffer_destroy(self.SoundBuffer)
    
    # samples
    
    cpdef SamplesWrapper get_samples(SoundBufferWrapper self):
        return Samples_wrap_ptr(self.get_samples_array())
    
    property samples:
        def __get__(SoundBufferWrapper self):
            return self.get_samples()
    
    # sample_count
    
    cpdef size_t get_sample_count(SoundBufferWrapper self):
        return caudio.SoundBuffer_get_sample_count(self.SoundBuffer)
    
    property sample_count:
        def __get__(SoundBufferWrapper self):
            return caudio.SoundBuffer_get_sample_count(self.SoundBuffer)
    
    # channel_count
    
    cpdef unsigned int get_channel_count(SoundBufferWrapper self):
        return caudio.SoundBuffer_get_channel_count(self.SoundBuffer)
    
    property channel_count:
        def __get__(SoundBufferWrapper self):
            return caudio.SoundBuffer_get_channel_count(self.SoundBuffer)
    
    # duration
    
    cpdef system.Time get_duration(SoundBufferWrapper self):
        return system.Time(caudio.SoundBuffer_get_duration(self.SoundBuffer))
    
    cpdef csystem.Time get_duration_struct(SoundBufferWrapper self):
        return caudio.SoundBuffer_get_duration(self.SoundBuffer)
    
    property duration:
        def __get__(SoundBufferWrapper self):
            return self.get_duration()


cdef class SoundBuffer(SoundBufferWrapper):
    def __init__(SoundBuffer self, const char* filename):
        self.SoundBuffer = caudio.SoundBuffer_create_from_file(filename)


# Sound
################################################################################

cdef SoundWrapper Sound_wrap_ptr(caudio.Sound* sound_ptr):
    cdef SoundWrapper sound = Sound()
    sound.Sound = sound_ptr
    return sound


cdef SoundWrapper Sound_create_from_file(const char* filename):
    cdef caudio.Sound* sound_ptr = caudio.Sound_create()
    caudio.Sound_set_buffer(sound_ptr, caudio.SoundBuffer_create_from_file(filename))
    return Sound_wrap_ptr(sound_ptr)


cdef SoundWrapper Sound_create_from_sound_buffer(SoundBufferWrapper sound_buffer):
    cdef caudio.Sound* sound_ptr = caudio.Sound_create()
    caudio.Sound_set_buffer(sound_ptr, sound_buffer.SoundBuffer)
    return Sound_wrap_ptr(sound_ptr)


cdef class SoundWrapper:
    
    # Python constructors
    
    @staticmethod
    def from_file(const char* filename):
        return Sound_create_from_file(filename)
    
    @staticmethod
    def from_sound_buffer(SoundBufferWrapper sound_buffer):
        return Sound_create_from_sound_buffer(sound_buffer)
    
    # Special methods
    
    def __dealloc__(SoundWrapper self):
        if self.Sound:
            caudio.Sound_destroy(self.Sound)
    
    # Cython methods
    
    cpdef destroy(SoundWrapper self):
        if self.Sound:
            caudio.Sound_destroy(self.Sound)
            self.Sound = NULL
    
    cpdef play(SoundWrapper self):
        caudio.Sound_play(self.Sound)
    
    cpdef pause(SoundWrapper self):
        caudio.Sound_pause(self.Sound)
    
    cpdef stop(SoundWrapper self):
        caudio.Sound_stop(self.Sound)
    
    # buffer
    
    cpdef set_buffer(SoundWrapper self, SoundBufferWrapper sound_buffer):
        caudio.Sound_set_buffer(self.Sound, sound_buffer.SoundBuffer)
    
    cpdef SoundBufferWrapper get_buffer(SoundWrapper self):
        return SoundBuffer_wrap_ptr(caudio.Sound_get_buffer(self.Sound))
    
    property buffer:
        def __get__(SoundWrapper self):
            return self.get_buffer()
        
        def __set__(SoundWrapper self, SoundBufferWrapper sound_buffer):
            self.set_buffer(sound_buffer)
    
    # loop
    
    cpdef set_loop(SoundWrapper self, bint loop):
        caudio.Sound_set_loop(self.Sound, loop)
    
    cpdef bint get_loop(SoundWrapper self):
        return caudio.Sound_get_loop(self.Sound)
    
    property loop:
        def __get__(SoundWrapper self):
            return self.get_loop()
        
        def __set__(SoundWrapper self, bint loop):
            self.set_loop(loop)
    
    # status
    
    cpdef caudio.SoundStatus get_status(SoundWrapper self):
        return caudio.Sound_get_status(self.Sound)
    
    property status:
        def __get__(SoundWrapper self):
            return self.get_status()
    
    # pitch
    
    cpdef set_pitch(SoundWrapper self, float pitch):
        caudio.Sound_set_pitch(self.Sound, pitch)
    
    cpdef float get_pitch(SoundWrapper self):
        return caudio.Sound_get_pitch(self.Sound)
    
    property pitch:
        def __get__(SoundWrapper self):
            return self.get_pitch()
        
        def __set__(SoundWrapper self, float pitch):
            self.set_pitch(pitch)
    
    # volume
    
    cpdef set_volume(SoundWrapper self, float volume):
        caudio.Sound_set_volume(self.Sound, volume)
    
    cpdef float get_volume(SoundWrapper self):
        return caudio.Sound_get_volume(self.Sound)
    
    property volume:
        def __get__(SoundWrapper self):
            return self.get_volume()
        
        def __set__(SoundWrapper self, float volume):
            self.set_volume(volume)
    
    # position
    
    cpdef set_position(SoundWrapper self, position):
        caudio.Sound_set_position(self.Sound, system.Vector3f_cast(position))
    
    cpdef set_position_vector(SoundWrapper self, csystem.Vector3f position):
        caudio.Sound_set_position(self.Sound, position)
    
    cpdef set_position_xyz(SoundWrapper self, float x, float y, float z):
        caudio.Sound_set_position(self.Sound, system.Vector3f(x, y, z))
    
    cpdef tuple get_position(SoundWrapper self):
        return system.Vector3f_unpack(caudio.Sound_get_position(self.Sound))
    
    cpdef csystem.Vector3f get_position_vector(SoundWrapper self):
        return caudio.Sound_get_position(self.Sound)
    
    cpdef tuple get_position_xyz(SoundWrapper self):
        return system.Vector3f_unpack(caudio.Sound_get_position(self.Sound))
    
    property position:
        def __get__(SoundWrapper self):
            return self.get_position_xyz()
        
        def __set__(SoundWrapper self, tuple xyz):
            self.set_position(xyz)
    
    # relative_to_listener
    
    cpdef set_relative_to_listener(SoundWrapper self, bint relative):
        caudio.Sound_set_relative_to_listener(self.Sound, relative)
    
    cpdef bint is_relative_to_listener(SoundWrapper self):
        return caudio.Sound_is_relative_to_listener(self.Sound)
    
    property relative_to_listener:
        def __get__(SoundWrapper self):
            return self.is_relative_to_listener()
        
        def __set__(SoundWrapper self, bint relative):
            self.set_relative_to_listener(relative)
    
    # min_distance
    
    cpdef set_min_distance(SoundWrapper self, float distance):
        caudio.Sound_set_min_distance(self.Sound, distance)
    
    cpdef float get_min_distance(SoundWrapper self):
        return caudio.Sound_get_min_distance(self.Sound)
    
    property min_distance:
        def __get__(SoundWrapper self):
            return self.get_min_distance()
        
        def __set__(SoundWrapper self, float min_distance):
            self.set_min_distance(min_distance)
    
    # attenuation
    
    cpdef set_attenuation(SoundWrapper self, float attenuation):
        caudio.Sound_set_attenuation(self.Sound, attenuation)
    
    cpdef float get_attenuation(SoundWrapper self):
        return caudio.Sound_get_attenuation(self.Sound)
    
    property attenuation:
        def __get__(SoundWrapper self):
            return self.get_attenuation()
        
        def __set__(SoundWrapper self, float attenuation):
            self.set_attenuation(attenuation)
    
    # playing_offset
    
    cpdef set_playing_offset(SoundWrapper self, system.Time time_offset):
        caudio.Sound_set_playing_offset(self.Sound, time_offset.Time)
    
    cpdef system.Time get_playing_offset(SoundWrapper self):
        return system.Time(caudio.Sound_get_playing_offset(self.Sound))
    
    property playing_offset:
        def __get__(SoundWrapper self):
            return self.get_playing_offset()
        
        def __set__(SoundWrapper self, system.Time time_offset):
            self.set_playing_offset(time_offset)


cdef class Sound(SoundWrapper):
    def __init__(self):
        self.Sound = caudio.Sound_create()


# Listener
################################################################################

# global_volume

cpdef set_global_volume(float volume):
    caudio.Listener_set_global_volume(volume)


cpdef float get_global_volume():
    return caudio.Listener_get_global_volume()


# listener_position

cpdef set_listener_position(position):
    caudio.Listener_set_position(system.Vector3f_cast(position))


cpdef set_listener_position_vector(csystem.Vector3f position):
    caudio.Listener_set_position(position)


cpdef set_listener_position_xyz(float x, float y, float z):
    caudio.Listener_set_position(system.Vector3f(x, y, z))


cpdef tuple get_listener_position():
    return system.Vector3f_unpack(caudio.Listener_get_position())


cpdef csystem.Vector3f get_listener_position_vector():
    return caudio.Listener_get_position()


cpdef tuple get_listener_position_xyz():
    return system.Vector3f_unpack(caudio.Listener_get_position())


# listener_direction

cpdef set_listener_direction(orientation):
    caudio.Listener_set_direction(system.Vector3f_cast(orientation))


cpdef set_listener_direction_vector(csystem.Vector3f orientation):
    caudio.Listener_set_direction(orientation)


cpdef set_listener_direction_xyz(float x, float y, float z):
    caudio.Listener_set_direction(system.Vector3f(x, y, z))


cpdef tuple get_listener_direction():
    return system.Vector3f_unpack(caudio.Listener_get_direction())


cpdef csystem.Vector3f get_listener_direction_vector():
    return caudio.Listener_get_direction()


cpdef tuple get_listener_direction_xyz():
    return system.Vector3f_unpack(caudio.Listener_get_direction())


# Music
################################################################################

cdef MusicWrapper Music_wrap_ptr(caudio.Music* music_ptr):
    cdef MusicWrapper music = MusicWrapper()
    music.Music = music_ptr
    return music


cdef MusicWrapper Music_create_from_file(const char* filename):
    return Music_wrap_ptr(caudio.Music_create_from_file(filename))


cdef MusicWrapper Music_create_from_memory(const void* data, size_t size_in_bytes):
    return Music_wrap_ptr(caudio.Music_create_from_memory(data, size_in_bytes))


cdef class MusicWrapper:
    
    # Python constructors
    
    @staticmethod
    def from_file(const char* filename):
        return Music_create_from_file(filename)
    
    # Special methods
    
    def __dealloc__(MusicWrapper self):
        if self.Music:
            caudio.Music_destroy(self.Music)
    
    # Cython methods
    
    cpdef destroy(MusicWrapper self):
        if self.Music:
            caudio.Music_destroy(self.Music)
            self.Music = NULL
    
    cpdef play(MusicWrapper self):
        caudio.Music_play(self.Music)
    
    cpdef pause(MusicWrapper self):
        caudio.Music_pause(self.Music)
    
    cpdef stop(MusicWrapper self):
        caudio.Music_stop(self.Music)
    
    # duration
    
    cpdef system.Time get_duration(MusicWrapper self):
        return system.Time(caudio.Music_get_duration(self.Music))
    
    cpdef csystem.Time get_duration_struct(MusicWrapper self):
        return caudio.Music_get_duration(self.Music)
    
    property duration:
        def __get__(SoundBufferWrapper self):
            return self.get_duration()
    
    # channel_count
    
    cpdef unsigned int get_channel_count(MusicWrapper self):
        return caudio.Music_get_channel_count(self.Music)
    
    
    property channel_count:
        def __get__(MusicWrapper self):
            return self.get_channel_count()
    
    # sample_rate
    
    cpdef unsigned int get_sample_rate(MusicWrapper self):
        return caudio.Music_get_sample_rate(self.Music)
    
    property sample_rate:
        def __get__(MusicWrapper self):
            return self.get_sample_rate()
    
    # loop
    
    cpdef set_loop(MusicWrapper self, bint loop):
        caudio.Music_set_loop(self.Music, loop)
    
    cpdef bint get_loop(MusicWrapper self):
        return caudio.Music_get_loop(self.Music)
    
    property loop:
        def __get__(MusicWrapper self):
            return self.get_loop()
        
        def __set__(MusicWrapper self, bint loop):
            self.set_loop(loop)
    
    # status
    
    cpdef caudio.SoundStatus get_status(MusicWrapper self):
        return caudio.Music_get_status(self.Music)
    
    property status:
        def __get__(MusicWrapper self):
            return self.get_status()
    
    # pitch
    
    cpdef float get_pitch(MusicWrapper self):
        return caudio.Music_get_pitch(self.Music)
    
    cpdef set_pitch(MusicWrapper self, float pitch):
        caudio.Music_set_pitch(self.Music, pitch)
    
    property pitch:
        def __get__(MusicWrapper self):
            return self.get_pitch()
        
        def __set__(MusicWrapper self, float pitch):
            self.set_pitch(pitch)
    
    # volume
    
    cpdef float get_volume(MusicWrapper self):
        return caudio.Music_get_volume(self.Music)
    
    cpdef set_volume(MusicWrapper self, float volume):
        caudio.Music_set_volume(self.Music, volume)
    
    property volume:
        def __get__(MusicWrapper self):
            return self.get_volume()
        
        def __set__(MusicWrapper self, float volume):
            self.set_volume(volume)
    
    # position
    
    cpdef tuple get_position(MusicWrapper self):
        return system.Vector3f_unpack(self.get_position())
    
    cpdef csystem.Vector3f get_position_vector(MusicWrapper self):
        return caudio.Music_get_position(self.Music)
    
    cpdef tuple get_position_xyz(MusicWrapper self):
        return system.Vector3f_unpack(self.get_position())
    
    cpdef set_position(MusicWrapper self, position):
        caudio.Music_set_position(self.Music, system.Vector3f_cast(position))
    
    cpdef set_position_vector(MusicWrapper self, csystem.Vector3f position):
        caudio.Music_set_position(self.Music, position)
    
    cpdef set_position_xyz(MusicWrapper self, float x, float y, float z):
        caudio.Music_set_position(self.Music, system.Vector3f(x, y, z))
    
    property position:
        def __get__(MusicWrapper self):
            return self.get_position_xyz()
        
        def __set__(MusicWrapper self, tuple xyz):
            self.set_position_xyz(*xyz)    
    
    # relative_to_listener
    
    cpdef bint is_relative_to_listener(MusicWrapper self):
        return caudio.Music_is_relative_to_listener(self.Music)
    
    cpdef set_relative_to_listener(MusicWrapper self, bint relative):
        caudio.Music_set_relative_to_listener(self.Music, relative)
    
    property relative_to_listener:
        def __get__(MusicWrapper self):
            return self.get_relative_to_listener()
        
        def __set__(MusicWrapper self, bint relative):
            self.set_relative_to_listener(relative)
    
    # min_distance
    
    cpdef float get_min_distance(MusicWrapper self):
        return caudio.Music_get_min_distance(self.Music)
    
    cpdef set_min_distance(MusicWrapper self, float distance):
        caudio.Music_set_min_distance(self.Music, distance)
    
    property min_distance:
        def __get__(MusicWrapper self):
            return self.get_min_distance()
        
        def __set__(MusicWrapper self, float min_distance):
            self.set_min_distance(min_distance)
    
    # attenuation
    
    cpdef float get_attenuation(MusicWrapper self):
        return caudio.Music_get_attenuation(self.Music)
    
    cpdef set_attenuation(MusicWrapper self, float attenuation):
        caudio.Music_set_attenuation(self.Music, attenuation)
    
    property attenuation:
        def __get__(MusicWrapper self):
            return self.get_attenuation()
        
        def __set__(MusicWrapper self, float attenuation):
            self.set_attenuation(attenuation)
    
    # playing_offset
    
    cpdef set_playing_offset(MusicWrapper self, system.Time time_offset):
        caudio.Music_set_playing_offset(self.Music, time_offset.Time)
    
    cpdef system.Time get_playing_offset(MusicWrapper self):
        return system.Time(caudio.Music_get_playing_offset(self.Music))
    
    property playing_offset:
        def __get__(MusicWrapper self):
            return self.get_playing_offset()
        
        def __set__(MusicWrapper self, system.Time time_offset):
            self.set_playing_offset(time_offset)


cdef class Music(MusicWrapper):
    def __init__(self, const char* filename):
        self.Music = caudio.Music_create_from_file(filename)

