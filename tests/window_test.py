import unittest

from time import sleep

from cysfml.system import (
    Vector2i,
    Vector2u,
)
from cysfml.window import (
    ContextSettings,
    VideoMode,
    Window,
    desktop_mode,
    fullscreen_modes,
)


class TestWindow(unittest.TestCase):
    
    def setUp(self):
        self.window = Window(VideoMode(320, 240, 32), b'Test')
    
    def test_is_open(self):
        self.assertTrue(self.window.is_open())
        self.window.close()
        self.assertFalse(self.window.is_open())
    
    def test_positioning(self):
        
        def assert_position(x, y, delta_x=5, delta_y=50):
            # sleep is required before get_position() returns new position.
            sleep(0.002)
            result_x, result_y = self.window.get_position()
            self.assertAlmostEqual(result_x, x, delta=delta_x)
            self.assertAlmostEqual(result_y, y, delta=delta_y)
            result_x, result_y = self.window.get_position_xy()
            self.assertAlmostEqual(result_x, x, delta=delta_x)
            self.assertAlmostEqual(result_y, y, delta=delta_y)
            result = self.window.get_position_vector()
            self.assertAlmostEqual(result['x'], x, delta=delta_x)
            self.assertAlmostEqual(result['y'], y, delta=delta_y)
        
        x = 100
        y = 50
        self.window.set_position_vector(Vector2i(x, y))
        assert_position(x, y)
        x = 150
        y = 100
        self.window.set_position_xy(x, y)
        assert_position(x, y)
        x = 200
        y = 150
        self.window.set_position((x, y))
        assert_position(x, y)
        x = 250
        y = 200
        self.window.set_position(Vector2i(x, y))
        assert_position(x, y)
        x = 200
        self.window.set_x(x)
        assert_position(x, y, delta_y=100)
        x = 150
        self.window.x = x
        assert_position(x, y, delta_y=150)
        y = 150
        self.window.set_y(y)
        assert_position(x, y, delta_x=10)
        y = 100
        self.window.y = y
        assert_position(x, y, delta_x=15)
    
    def test_resizing(self):
        def assert_size(width, height):
            result_width, result_height = self.window.get_size()
            self.assertAlmostEqual(result_width, width)
            self.assertAlmostEqual(result_height, height)
            result_width, result_height = self.window.get_size_xy()
            self.assertAlmostEqual(result_width, width)
            self.assertAlmostEqual(result_height, height)
            result = self.window.get_size_vector()
            self.assertAlmostEqual(result['x'], width)
            self.assertAlmostEqual(result['y'], height)
        
        width = 100
        height = 50
        self.window.set_size_vector(Vector2u(width, height))
        assert_size(width, height)
        width = 150
        height = 100
        self.window.set_size_xy(width, height)
        assert_size(width, height)
        width = 200
        height = 150
        self.window.set_size((width, height))
        assert_size(width, height)
        width = 250
        height = 200
        self.window.set_size(Vector2u(width, height))
        assert_size(width, height)
        width = 200
        self.window.set_width(width)
        assert_size(width, height)
        width = 150
        self.window.width = width
        assert_size(width, height)
        height = 150
        self.window.set_height(height)
        assert_size(width, height)
        height = 100
        self.window.height = height
        assert_size(width, height)


class TestVideoMode(unittest.TestCase):
    def test_video_mode(self):
        width = 640
        height = 480
        bits_per_pixel = 32
        video_mode = VideoMode(width, height, bits_per_pixel)
        self.assertEqual(video_mode.get_width(), width)
        self.assertEqual(video_mode.width, width)
        self.assertEqual(video_mode.get_height(), height)
        self.assertEqual(video_mode.height, height)
        self.assertEqual(video_mode.get_bits_per_pixel(), bits_per_pixel)
        self.assertEqual(video_mode.bits_per_pixel, bits_per_pixel)
        # Assume very common resolution is valid.
        valid_video_mode = fullscreen_modes()[0]
        self.assertTrue(valid_video_mode.is_valid())
        self.assertTrue(valid_video_mode.valid)
        
        invalid_video_mode = VideoMode(544, 124, 99)
        self.assertFalse(invalid_video_mode.is_valid())
        self.assertFalse(invalid_video_mode.valid)


class TestDesktopMode(unittest.TestCase):
    def test_desktop_mode(self):
        try:
            import tkinter
        except ImportError:
            raise
            return
        root = tkinter.Tk()
        video_mode = desktop_mode()
        self.assertEqual(video_mode.width, root.winfo_screenwidth())
        self.assertEqual(video_mode.height, root.winfo_screenheight())


class TestFullscreenModes(unittest.TestCase):
    def test_fullscreen_modes(self):
        for video_mode in fullscreen_modes():
            self.assertTrue(video_mode.is_valid())


class TestContextSettings(unittest.TestCase):
    def test_context_settings(self):
        default_context_settings = ContextSettings()
        self.assertEqual(default_context_settings['depth_bits'], 0)
        self.assertEqual(default_context_settings['stencil_bits'], 0)
        self.assertEqual(default_context_settings['antialiasing_level'], 0)
        self.assertEqual(default_context_settings['major_version'], 2)
        self.assertEqual(default_context_settings['minor_version'], 0)
        kwargs = {
            'depth_bits': 1,
            'stencil_bits': 2,
            'antialiasing_level': 3,
            'major_version': 4,
            'minor_version': 5,
        }
        context_settings = ContextSettings(**kwargs)
        for key, value in kwargs.items():
            self.assertEqual(context_settings[key], value)


if __name__ == '__main__':
    unittest.main()

