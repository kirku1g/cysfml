from cysfml.cexample_window import ExampleWindow as CExampleWindow

from cysfml.example import (
    Example,
    example_from_args,
)
from cysfml.system import (
    create_vector2i,
    create_vector2u,
)
from cysfml.window import (
    create_video_mode,
    fullscreen_modes,
)


class ExampleVideoMode(Example):
    
    def _run(self):
        self.example_create_a_video_mode()
        self.example_check_if_a_video_mode_is_valid()
        self.example_list_fullscreen_modes()
    
    def example_create_a_video_mode(self):
        self.output('VideoModes are primarily used for creating windows...')
        self.output('Create a VideoMode by calling window.create_video_mode(320, 240, 32)...')
        video_mode = create_video_mode(320, 240, 32)
        self.output('video_mode.get_bits_per_pixel() == video_mode.bits_per_pixel == %d' % video_mode.bits_per_pixel)
        self.output('video_mode.get_width() == video_mode.width == %d' % video_mode.width)
        self.output('video_mode.get_height() == video_mode.height == %d' % video_mode.height)
    
    def example_check_if_a_video_mode_is_valid(self):
        self.output('We can check if a video mode is valid by calling video_mode.is_valid()...')
        video_mode = create_video_mode(640, 480, 32)
        self.output('%s.is_valid() == video_mode.valid == %s' % (repr(video_mode), video_mode.is_valid()))
        video_mode = create_video_mode(475, 112, 17)
        self.output('%s.is_valid() == video_mode.valid == %s' % (repr(video_mode), video_mode.is_valid()))
    
    def example_list_fullscreen_modes(self):
        self.output('We can retrieve a list of all fullscreen video modes by calling window.fullscreen_modes()...')
        self.output('The following fullscreen modes are supported:')
        self.output('\n'.join(' - %s' % v for v in fullscreen_modes()))


if __name__ == '__main__':
    example_from_args({
        'python': ExampleVideoMode,
    }).run()
