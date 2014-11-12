from config cimport (
    Int16,
    Uint32,
)

cimport csystem

# SFML/Audio/Types.h
################################################################################

cdef extern from 'SFML/Audio/Types.h' nogil:
    ctypedef struct Music 'sfMusic'
    ctypedef struct Sound 'sfSound'
    ctypedef struct SoundBuffer 'sfSoundBuffer'
    ctypedef struct SoundBufferRecorder 'sfSoundBufferRecorder'
    ctypedef struct SoundRecorder 'sfSoundRecorder'
    ctypedef struct SoundStream 'sfSoundStream'


# SFML/Audio/SoundBuffer.h
################################################################################

cdef extern from 'SFML/Audio/SoundBuffer.h' nogil:
    cdef SoundBuffer* SoundBuffer_create_from_file 'sfSoundBuffer_createFromFile' (const char* filename)
    cdef SoundBuffer* SoundBuffer_create_from_memory 'sfSoundBuffer_createFromMemory' (const void* data, size_t sizeInBytes)
    cdef SoundBuffer* SoundBuffer_create_from_stream 'sfSoundBuffer_createFromStream' (csystem.InputStream* stream)
    cdef SoundBuffer* SoundBuffer_copy 'sfSoundBuffer_copy' (SoundBuffer* soundBuffer)
    cdef void SoundBuffer_destroy 'sfSoundBuffer_destroy' (SoundBuffer* soundBuffer)
    cdef bint SoundBuffer_save_to_file 'sfSoundBuffer_saveToFile' (SoundBuffer* soundBuffer, const char* filename)
    cdef const Int16* SoundBuffer_get_samples 'sfSoundBuffer_getSamples' (const SoundBuffer* soundBuffer)
    cdef size_t SoundBuffer_get_sample_count 'sfSoundBuffer_getSampleCount' (const SoundBuffer* soundBuffer)
    cdef unsigned int SoundBuffer_get_sample_rate 'sfSoundBuffer_getSampleRate' (const SoundBuffer* soundBuffer)
    cdef unsigned int SoundBuffer_get_channel_count 'sfSoundBuffer_getChannelCount' (const SoundBuffer* soundBuffer)
    cdef csystem.Time SoundBuffer_get_duration 'sfSoundBuffer_getDuration' (const SoundBuffer* soundBuffer)


# SFML/Audio/SoundStatus.h
################################################################################

cdef extern from 'SFML/Audio/SoundStatus.h' nogil:
    ctypedef enum SoundStatus 'sfSoundStatus':
        SOUND_STATUS_STOPPED 'sfStopped'
        SOUND_STATUS_PAUSED 'sfPaused'
        SOUND_STATUS_PLAYING 'sfPlaying'


# SFML/Audio/Sound.h
################################################################################

cdef extern from 'SFML/Audio/Sound.h' nogil:
    cdef Sound* Sound_create 'sfSound_create' ()
    cdef Sound* Sound_copy 'sfSound_copy' (const Sound* sound)
    cdef void Sound_destroy 'sfSound_destroy' (Sound* sound)
    cdef void Sound_play 'sfSound_play' (Sound* sound)
    cdef void Sound_pause 'sfSound_pause' (Sound* sound)
    cdef void Sound_stop 'sfSound_stop' (Sound* sound)
    cdef void Sound_set_buffer 'sfSound_setBuffer' (Sound* sound, const SoundBuffer* buffer)
    cdef const SoundBuffer* Sound_get_buffer 'sfSound_getBuffer' (Sound* sound)
    cdef const SoundBuffer* Sound_set_loop 'sfSound_setLoop' (Sound* sound, bint loop)
    cdef bint Sound_get_loop 'sfSound_getLoop' (Sound* sound)
    cdef SoundStatus Sound_get_status 'sfSound_getStatus' (Sound* sound)
    cdef void Sound_set_pitch 'sfSound_setPitch' (Sound* sound, float pitch)
    cdef void Sound_set_volume 'sfSound_setVolume' (Sound* sound, float volume)
    cdef void Sound_set_position 'sfSound_setPosition' (Sound* sound, csystem.Vector3f position)
    cdef void Sound_set_relative_to_listener 'sfSound_setRelativeToListener' (Sound* sound, bint relative)
    cdef void Sound_set_min_distance 'sfSound_setMinDistance' (Sound* sound, float distance)
    cdef void Sound_set_attenuation 'sfSound_setAttenuation' (Sound* sound, float attenuation)
    cdef void Sound_set_playing_offset 'sfSound_setPlayingOffset' (Sound* sound, csystem.Time timeOffset)
    cdef float Sound_get_pitch 'sfSound_getPitch' (const Sound* sound)
    cdef float Sound_get_volume 'sfSound_getVolume' (const Sound* sound)
    cdef csystem.Vector3f Sound_get_position 'sfSound_getPosition' (const Sound* sound)
    cdef bint Sound_is_relative_to_listener 'sfSound_isRelativeToListener' (const Sound* sound)
    cdef float Sound_get_min_distance 'sfSound_getMinDistance' (const Sound* sound)
    cdef float Sound_get_attenuation 'sfSound_getAttenuation' (const Sound* sound)
    cdef csystem.Time Sound_get_playing_offset 'sfSound_getPlayingOffset' (const Sound* sound)


# SFML/Audio/Listener.h
################################################################################

cdef extern from 'SFML/Audio/Listener.h' nogil:
    cdef void Listener_set_global_volume 'sfListener_setGlobalVolume' (float volume)
    cdef float Listener_get_global_volume 'sfListener_getGlobalVolume' ()
    cdef void Listener_set_position 'sfListener_setPosition' (csystem.Vector3f position)
    cdef csystem.Vector3f Listener_get_position 'sfListener_getPosition' ()
    cdef void Listener_set_direction 'sfListener_setDirection' (csystem.Vector3f orientation)
    cdef csystem.Vector3f Listener_get_direction 'sfListener_getDirection' ()


# SFML/Audio/Music.h
################################################################################

cdef extern from 'SFML/Audio/Music.h' nogil:
    cdef Music* Music_create_from_file 'sfMusic_createFromFile' (const char* filename)
    cdef Music* Music_create_from_memory 'sfMusic_createFromMemory' (const void* data, size_t sizeInBytes)
    cdef Music* Music_create_from_stream 'sfMusic_createFromStream' (csystem.InputStream* stream)
    cdef void Music_destroy 'sfMusic_destroy' (Music* music)
    cdef void Music_set_loop 'sfMusic_setLoop' (Music* music, bint loop)
    cdef bint Music_get_loop 'sfMusic_getLoop' (Music* music)
    cdef csystem.Time Music_get_duration 'sfMusic_getDuration' (const Music* music)
    cdef void Music_play 'sfMusic_play' (Music* music)
    cdef void Music_pause 'sfMusic_pause' (Music* music)
    cdef void Music_stop 'sfMusic_stop' (Music* music)
    cdef unsigned int Music_get_channel_count 'sfMusic_getChannelCount' (const Music* music)
    cdef unsigned int Music_get_sample_rate 'sfMusic_getSampleRate' (const Music* music)
    cdef SoundStatus Music_get_status 'sfMusic_getStatus' (const Music* music)
    cdef csystem.Time Music_get_playing_offset 'sfMusic_getPlayingOffset' (const Music* music)
    cdef void Music_set_pitch 'sfMusic_setPitch' (Music* music, float pitch)
    cdef void Music_set_volume 'sfMusic_setVolume' (Music* music, float volume)
    cdef void Music_set_position 'sfMusic_setPosition' (Music* music, csystem.Vector3f position)
    cdef void Music_set_relative_to_listener 'sfMusic_setRelativeToListener' (Music* music, bint relative)
    cdef void Music_set_min_distance 'sfMusic_setMinDistance' (Music* music, float distance)
    cdef void Music_set_attenuation 'sfMusic_setAttenuation' (Music* music, float attenuation)
    cdef void Music_set_playing_offset 'sfMusic_setPlayingOffset' (Music* music, csystem.Time timeOffset)
    cdef float Music_get_pitch 'sfMusic_getPitch' (Music* music)
    cdef float Music_get_volume 'sfMusic_getVolume' (Music* music)
    cdef csystem.Vector3f Music_get_position 'sfMusic_getPosition' (Music* music)
    cdef bint Music_is_relative_to_listener 'sfMusic_isRelativeToListener' (const Music* music)
    cdef float Music_get_min_distance 'sfMusic_getMinDistance' (const Music* music)
    cdef float Music_get_attenuation 'sfMusic_getAttenuation' (const Music* music)


# SFML/Audio/SoundStream.h
################################################################################

cdef extern from 'SFML/Audio/SoundStream.h' nogil:
    ctypedef struct SoundStreamChunk 'sfSoundStreamChunk':
        Int16* samples
        unsigned int sample_count 'sampleCount'
    
    ctypedef bint (*SoundStreamGetDataCallback 'sfSoundStreamGetDataCallback')(SoundStreamChunk*, void*)
    ctypedef void (*SoundStreamSeekCallback 'sfSoundStreamSeekCallback')(csystem.Time, void*)
    
    cdef void SoundStream_destroy 'sfSoundStream_destroy' (SoundStream* soundStream)
    cdef void SoundStream_play 'sfSoundStream_play' (SoundStream* soundStream)
    cdef void SoundStream_pause 'sfSoundStream_pause' (SoundStream* soundStream)
    cdef void SoundStream_stop 'sfSoundStream_stop' (SoundStream* soundStream)
    cdef SoundStatus SoundStream_get_status 'sfSoundStream_getStatus' (const SoundStream* soundStream)
    cdef unsigned int SoundStream_get_channel_count 'sfSoundStream_getChannelCount' (const SoundStream* soundStream)
    cdef unsigned int SoundStream_get_sample_rate 'sfSoundStream_getSampleRate' (const SoundStream* soundStream)
    cdef void SoundStream_set_pitch 'sfSoundStream_setPitch' (SoundStream* soundStream, float pitch)
    cdef void SoundStream_set_volume 'sfSoundStream_setVolume' (SoundStream* soundStream, float volume)
    cdef void SoundStream_set_position 'sfSoundStream_setPosition' (SoundStream* soundStream, csystem.Vector3f position)
    cdef void SoundStream_set_relative_to_listener 'sfSoundStream_setRelativeToListener' (SoundStream* soundStream, bint relative)
    cdef void SoundStream_set_min_distance 'sfSoundStream_setMinDistance' (SoundStream* soundStream, float distance)
    cdef void SoundStream_set_attenuation 'sfSoundStream_setAttenuation' (SoundStream* soundStream, float attenuation)
    cdef void SoundStream_set_playing_offset 'sfSoundStream_setPlayingOffset' (SoundStream* soundStream, csystem.Time timeOffset)
    cdef void SoundStream_set_loop 'sfSoundStream_setLoop' (SoundStream* soundStream, bint loop)
    cdef float SoundStream_get_pitch 'sfSoundStream_getPitch' (const SoundStream* soundStream)
    cdef float SoundStream_get_volume 'sfSoundStream_getVolume' (const SoundStream* soundStream)
    cdef bint SoundStream_is_relative_to_listener 'sfSoundStream_isRelativeToListener' (const SoundStream* soundStream)
    cdef float SoundStream_get_min_distance 'sfSoundStream_getMinDistance' (const SoundStream* soundStream)
    cdef float SoundStream_get_attenuation 'sfSoundStream_getAttenuation' (const SoundStream* soundStream)
    cdef bint SoundStream_get_loop 'sfSoundStream_getLoop' (const SoundStream* soundStream)
    cdef csystem.Time SoundStream_get_playing_offset 'sfSoundStream_getPlayingOffset' (const SoundStream* soundStream)


# SFML/Audio/SoundRecorder.h
################################################################################

cdef extern from 'SFML/Audio/SoundRecorder.h' nogil:
    ctypedef bint (*SoundRecorderStartCallback 'sfSoundRecorderStartCallback')(void*)
    ctypedef bint (*SoundRecorderProcessCallback 'sfSoundRecorderProcessCallback')(const Int16*, size_t, void*)
    ctypedef void (*SoundRecorderStopCallback 'sfSoundRecorderStopCallback')(void*)
    
    cdef void SoundRecorder_create 'sfSoundRecorder_create' (SoundRecorderStartCallback onStart, SoundRecorderProcessCallback onProcess, SoundRecorderStopCallback onStop, void* userData)
    cdef void SoundRecorder_destroy 'sfSoundRecorder_destroy' (SoundRecorder* soundRecorder)
    cdef void SoundRecorder_start 'sfSoundRecorder_start' (SoundRecorder* soundRecorder)
    cdef void SoundRecorder_stop 'sfSoundRecorder_stop' (SoundRecorder* soundRecorder)
    cdef unsigned int SoundRecorder_getSampleRate 'sfSoundRecorder_getSampleRate' (const SoundRecorder* soundRecorder)
    cdef bint SoundRecorder_isAvailable 'sfSoundRecorder_isAvailable' ()

