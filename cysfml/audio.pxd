from config cimport Int16

cimport csystem
cimport system

cimport caudio


# SoundBuffer
################################################################################

cdef SamplesWrapper Samples_wrap_ptr(Int16* samples_ptr)


cdef class SamplesWrapper:
    cdef Int16* Samples


cdef SoundBufferWrapper SoundBuffer_wrap_ptr(caudio.SoundBuffer* sound_buffer_ptr)
cdef SoundBufferWrapper SoundBuffer_create_from_file(const char* filename)
cdef SoundBufferWrapper SoundBuffer_create_from_memory(const void* data, size_t size_in_bytes)


cdef class SoundBufferWrapper:
    cdef caudio.SoundBuffer* SoundBuffer
    
    # Cython methods
    cpdef destroy(SoundBufferWrapper self)
    cpdef SoundBufferWrapper copy(SoundBufferWrapper self)
    cpdef save_to_file(SoundBufferWrapper self, const char* filename)
    cdef const Int16* get_samples_array(SoundBufferWrapper self)
    # samples
    cpdef SamplesWrapper get_samples(SoundBufferWrapper self)
    # sample_count
    cpdef size_t get_sample_count(SoundBufferWrapper self)
    # channel_count
    cpdef unsigned int get_channel_count(SoundBufferWrapper self)
    # duration
    cpdef system.Time get_duration(SoundBufferWrapper self)
    cpdef csystem.Time get_duration_struct(SoundBufferWrapper self)


cdef class SoundBuffer(SoundBufferWrapper):
    pass


# Sound
################################################################################

cdef SoundWrapper Sound_wrap_ptr(caudio.Sound* sound_ptr)
cdef SoundWrapper Sound_create_from_file(const char* filename)
cdef SoundWrapper Sound_create_from_sound_buffer(SoundBufferWrapper sound_buffer)


cdef class SoundWrapper:
    cdef caudio.Sound* Sound
    
    # Cython methods
    cpdef destroy(SoundWrapper self)
    cpdef play(SoundWrapper self)
    cpdef pause(SoundWrapper self)
    cpdef stop(SoundWrapper self)
    # buffer
    cpdef set_buffer(SoundWrapper self, SoundBufferWrapper sound_buffer)
    cpdef SoundBufferWrapper get_buffer(SoundWrapper self)
    # loop
    cpdef set_loop(SoundWrapper self, bint loop)
    cpdef bint get_loop(SoundWrapper self)
    # status
    cpdef caudio.SoundStatus get_status(SoundWrapper self)
    # pitch
    cpdef set_pitch(SoundWrapper self, float pitch)
    cpdef float get_pitch(SoundWrapper self)
    # volume
    cpdef set_volume(SoundWrapper self, float volume)
    cpdef float get_volume(SoundWrapper self)
    # position
    cpdef set_position(SoundWrapper self, position)
    cpdef set_position_vector(SoundWrapper self, csystem.Vector3f position)
    cpdef set_position_xyz(SoundWrapper self, float x, float y, float z)
    cpdef tuple get_position(SoundWrapper self)
    cpdef csystem.Vector3f get_position_vector(SoundWrapper self)
    cpdef tuple get_position_xyz(SoundWrapper self)
    # relative_to_listener
    cpdef set_relative_to_listener(SoundWrapper self, bint relative)
    cpdef bint is_relative_to_listener(SoundWrapper self)
    # min_distance
    cpdef set_min_distance(SoundWrapper self, float distance)
    cpdef float get_min_distance(SoundWrapper self)
    # attenuation
    cpdef set_attenuation(SoundWrapper self, float attenuation)
    cpdef float get_attenuation(SoundWrapper self)
    # playing_offset
    cpdef set_playing_offset(SoundWrapper self, system.Time time_offset)
    cpdef system.Time get_playing_offset(SoundWrapper self)


cdef class Sound(SoundWrapper):
    pass


# Listener
################################################################################

# global_volume

cpdef set_global_volume(float volume)
cpdef float get_global_volume()

# listener_position

cpdef set_listener_position(position)
cpdef set_listener_position_vector(csystem.Vector3f position)
cpdef set_listener_position_xyz(float x, float y, float z)
cpdef tuple get_listener_position()
cpdef csystem.Vector3f get_listener_position_vector()
cpdef tuple get_listener_position_xyz()

# listener_direction

cpdef set_listener_direction(orientation)
cpdef set_listener_direction_vector(csystem.Vector3f orientation)
cpdef set_listener_direction_xyz(float x, float y, float z)
cpdef tuple get_listener_direction()
cpdef csystem.Vector3f get_listener_direction_vector()
cpdef tuple get_listener_direction_xyz()


# Music
################################################################################

cdef MusicWrapper Music_wrap_ptr(caudio.Music* music_ptr)
cdef MusicWrapper Music_create_from_file(const char* filename)
cdef MusicWrapper Music_create_from_memory(const void* data, size_t size_in_bytes)


cdef class MusicWrapper:
    cdef caudio.Music* Music
    
    # duration
    cpdef system.Time get_duration(MusicWrapper self)
    cpdef csystem.Time get_duration_struct(MusicWrapper self)
    # Cython methods
    cpdef destroy(MusicWrapper self)
    cpdef play(MusicWrapper self)
    cpdef pause(MusicWrapper self)
    cpdef stop(MusicWrapper self)
    # channel_count
    cpdef unsigned int get_channel_count(MusicWrapper self)
    # sample_rate
    cpdef unsigned int get_sample_rate(MusicWrapper self)
    # loop
    cpdef set_loop(MusicWrapper self, bint loop)
    cpdef bint get_loop(MusicWrapper self)
    # status
    cpdef caudio.SoundStatus get_status(MusicWrapper self)
    # pitch
    cpdef float get_pitch(MusicWrapper self)
    cpdef set_pitch(MusicWrapper self, float pitch)
    # volume
    cpdef float get_volume(MusicWrapper self)
    cpdef set_volume(MusicWrapper self, float volume)
    # position
    cpdef tuple get_position(MusicWrapper self)
    cpdef csystem.Vector3f get_position_vector(MusicWrapper self)
    cpdef tuple get_position_xyz(MusicWrapper self)
    cpdef set_position(MusicWrapper self, position)
    cpdef set_position_vector(MusicWrapper self, csystem.Vector3f position)
    cpdef set_position_xyz(MusicWrapper self, float x, float y, float z)
    cpdef bint is_relative_to_listener(MusicWrapper self)
    cpdef set_relative_to_listener(MusicWrapper self, bint relative)
    # min_distance
    cpdef float get_min_distance(MusicWrapper self)
    cpdef set_min_distance(MusicWrapper self, float distance)
    # attenuation
    cpdef float get_attenuation(MusicWrapper self)
    cpdef set_attenuation(MusicWrapper self, float attenuation)
    # playing_offset
    cpdef set_playing_offset(MusicWrapper self, system.Time time_offset)
    cpdef system.Time get_playing_offset(MusicWrapper self)


cdef class Music(MusicWrapper):
    pass

