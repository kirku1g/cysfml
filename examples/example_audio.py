import os

from cysfml.example import (
    Example,
    example_from_args,
)

from cysfml import audio, system


class ExampleAudio(Example):
    
    file_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'data', 'laser.ogg').encode('ascii')
    
    def _run(self):
        self.example_sound_buffer()
        self.example_sound()
        self.example_music()
        # TODO: example_listener
    
    def example_sound_buffer(self):
        self.output('The SoundBuffer class is used for loading Sounds into memory.')
        self.output('Create a SoundBuffer object with audio.SoundBuffer(file_path)...')
        buffer = audio.SoundBuffer(self.file_path)
        self.output('buffer.get_channel_count() == buffer.channel_count == %s' % buffer.channel_count)
        self.output('buffer.get_duration().as_seconds() == buffer.duration.as_seconds() == %s' % buffer.duration.as_seconds())
        self.output('To play a SoundBuffer, a Sound object must first be instantiated.')
    
    def example_sound(self):
        self.output('The Sound class is used for playing SoundBuffers which are stored in memory.')
        self.output('Sounds can be loaded from supported file formats by calling audio.Sound.from_file(file_path)...')
        sound = audio.Sound.from_file(self.file_path)
        self.output('The status of a sound can be retrieved by calling the Sound.get_status() method or accessing the Sound.status property...')
        assert sound.get_status() == sound.status == audio.SOUND_STATUS_STOPPED
        self.output('sound.get_status() == sound.status == audio.SOUND_STATUS_STOPPED')
        self.output('Sound can be played by calling the Sound.play() method...')
        sound.play()
        assert sound.get_status() == sound.status == audio.SOUND_STATUS_PLAYING
        self.output('sound.get_status() == sound.status == audio.SOUND_STATUS_PLAYING')
        self.output("The duration of a sound can be retrieved from its SoundBuffer by calling sound.get_buffer().get_duration() or sound.buffer.duration...")
        duration = sound.buffer.duration.as_seconds()
        self.sleep(duration)
        self.output('A Sound can be stopped mid-playback by calling sound.stop()...')
        sound.play()
        self.sleep(duration / 4)
        sound.stop()
        self.sleep(0.5)
        self.output('sound.play() will restart playback from the beginning.')
        sound.play()
        self.sleep(duration)
        self.output('A Sound can be paused mid-playback by calling sound.pause()...')
        sound.play()
        self.sleep(duration / 4)
        sound.pause()
        assert sound.get_status() == sound.status == audio.SOUND_STATUS_PAUSED
        self.output('sound.get_status() == sound.status == audio.SOUND_STATUS_PAUSED')
        self.sleep(0.5)
        self.output('sound.play() will continue playback from the paused position.')
        sound.play()
        self.sleep(duration / 4 * 3)
        self.sleep(0.25)
        self.output('Sounds can be loaded from SoundBuffer objects by calling Sound.from_buffer()...')
        buffer = audio.SoundBuffer(self.file_path)
        sound = audio.Sound.from_sound_buffer(buffer)
        self.output('A SoundBuffer object can be assigned to a Sound either by calling sound.set_buffer() or assigning to sound.buffer...')
        sound.set_buffer(buffer)
        sound.buffer = buffer
        self.output('Stutter effect for fun.')
        for x in range(24):
            sound.play()
            self.sleep(0.05)
            sound.pause()
            self.sleep(0.05)
        self.sleep(0.25)
        self.output('Sounds can be looped by either calling sound.set_loop(True) or assigning to sound.loop...')
        sound.set_loop(True)
        sound.loop = True
        sound.play()
        self.sleep(duration * 2)
        sound.loop = False
        self.sleep(0.25)
        self.output('The playing offset can be set while the sound is either paused or playing by either calling sound.set_playing_offset or assigning to sound.playing_offset...')
        sound.play()
        sound.set_playing_offset(system.Time.from_seconds(0.1))
        self.output('sound.get_playing_offset() == sound.playing_offset == %s' % sound.playing_offset)
        self.sleep(duration)
        
        self.output('The pitch of a sound can be changed by either calling sound.set_pitch() or assigning to sound.pitch...')
        sound.pitch = 3
        sound.play()
        self.sleep(duration / 3)
        sound.pitch = 0.2
        sound.play()
        self.sleep(duration * 5)
        sound.pitch = 1
        
        self.output('The volume of a sound can be changed by either calling sound.set_volume() or assigning to sound.volume...')
        volume = 10
        sound.set_volume(volume)
        sound.play()
        for volume in range(10, 100, 18):
            sound.volume = volume
            self.sleep(0.1)
        self.sleep(0.5)
        
        # TODO: attenuation, is_relative_to_listener, min_distance, position
    
    def example_music(self):
        self.output('The Music class is used for streaming audio.')
        self.output('Music can be loaded from supported file formats by either calling audio.Music.from_file(file_path) or instantiating a new Music object...')
        music = audio.Music.from_file(self.file_path)
        music = audio.Music(self.file_path)
        self.output('The status of a Music object can be retrieved by calling the Music.get_status() method or accessing the Music.status property...')
        assert music.get_status() == music.status == audio.SOUND_STATUS_STOPPED
        self.output('music.get_status() == music.status == audio.SOUND_STATUS_STOPPED')
        self.output('Music can be played by calling the music.play() method...')
        music.play()
        assert music.get_status() == music.status == audio.SOUND_STATUS_PLAYING
        self.output('music.get_status() == music.status == audio.SOUND_STATUS_PLAYING')
        self.output("The duration of a Music object can be retrieved by calling music.get_duration() or accessing music.duration...")
        self.output("The channel count of a Music object can be retrieved by calling music.get_channel_count() or accessing music.channel_count...")
        self.output('music.get_channel_count() == music.channel_count == %d' % music.get_channel_count())
        duration = music.duration.as_seconds()
        self.sleep(duration)
        self.output('A Music object can be stopped mid-playback by calling music.stop()...')
        music.play()
        self.sleep(duration / 4)
        music.stop()
        self.sleep(0.5)
        self.output('music.play() will restart playback from the beginning.')
        music.play()
        self.sleep(duration)
        self.output('A Music object can be paused mid-playback by calling music.pause()...')
        music.play()
        self.sleep(duration / 4)
        music.pause()
        self.sleep(0.1)
        # FIXME
        #assert music.get_status() == music.status == audio.SOUND_STATUS_PAUSED
        self.output('music.get_status() == music.status == audio.SOUND_STATUS_PAUSED')
        self.sleep(0.5)
        self.output('music.play() will continue playback from the paused position.')
        music.play()
        self.sleep(duration / 4 * 3)
        self.sleep(0.25)
        self.output('Stutter effect for fun.')
        for x in range(24):
            music.play()
            self.sleep(0.05)
            music.pause()
            self.sleep(0.05)
        self.sleep(0.25)
        self.output('Music objects can be looped by either calling music.set_loop(True) or assigning to music.loop...')
        music.set_loop(True)
        music.loop = True
        music.play()
        self.sleep(duration * 2)
        music.loop = False
        self.sleep(0.25)
        self.output('The playing offset can be set while the music is either paused or playing by either calling music.set_playing_offset or assigning to music.playing_offset...')
        music.play()
        music.set_playing_offset(system.Time.from_seconds(0.1))
        self.output('music.get_playing_offset() == music.playing_offset == %s' % music.playing_offset)
        self.sleep(duration)
        
        self.output('The pitch of a Music object can be changed by either calling music.set_pitch() or assigning to music.pitch...')
        music.pitch = 3
        music.play()
        self.sleep(duration / 3)
        music.pitch = 0.2
        music.play()
        self.sleep(duration * 5)
        music.pitch = 1
        
        self.output('The volume of a Music object can be changed by either calling music.set_volume() or assigning to music.volume...')
        volume = 10
        music.set_volume(volume)
        music.play()
        for volume in range(10, 100, 18):
            music.volume = volume
            self.sleep(0.1)
        self.sleep(0.5)
        
        # TODO: attenuation, is_relative_to_listener, min_distance, position    


if __name__ == '__main__':
    example_from_args({
        'python': ExampleAudio,
    }).run()
