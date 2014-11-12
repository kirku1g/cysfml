from random import choice, randint

from cysfml.example import (
    Example,
    example_from_args,
)
from cysfml.system import (
    Vector2i,
    Vector2u,
)
from cysfml.window import (
    VideoMode,
    Window,
)

#from cysfml.cexample_window import ExampleWindow as CExampleWindow


class ExampleWindow(Example):
    
    def _run(self):
        self.example_create_a_window()
        self.example_mouse_cursor_visibility()
        self.example_position_a_window()
        self.example_resize_a_window()
        self.example_window_visibility()
        #self.example_set_window_icon()
    
    @staticmethod
    def _create_window(name):
        video_mode = VideoMode(320, 240, 32)
        return Window(video_mode, name)
    
    def example_create_a_window(self):
        self.output('Create a window by calling graphics.create_window()...')
        window = self._create_window(b'Example Window')
        self.output('Check if a window is open by calling window.is_open()...')
        self.output('window.is_open() == %s...' % window.is_open())
        self.sleep(2)
        self.output('The window can be closed by calling window.close()')
        window.close()
        self.sleep(0.5)
        self.output('The window is closed (deallocated) when the object falls out of scope...')
    
    def example_position_a_window(self):
        window = self._create_window(b'Example Window Positioning')
        window.set_mouse_cursor_visible(False)
        
        self.output('Windows can also be positioned with x and y co-ordinates object using window.set_position_xy()...')
        for x in range(50, 100):
            window.set_position_xy(x, x)
            self.sleep(0.05)
        
        self.output('Windows can also be positioned with a Vector2i object using window.set_position_vector()...')
        for x in range(50):
            window.set_position_vector(Vector2i(x, x))
            self.sleep(0.05)
        
        self.output('window.set_position() accepts either an x, y tuple or a Vector2i object...')
        window.set_position((x, x))
        window.set_position(Vector2i(x, x))
        
        self.output('Windows can also be positioned by assigning an x, y tuple to the position property...')
        for x in range(100, 150):
            window.position = x, x
            self.sleep(0.05)
        
        self.output("Strangely, get_position() returns a window position that is offset by window borders...")
        window_x, window_y = window.get_position_xy()
        self.output("window.get_position() == %s (tuple)" % (window.get_position(),))
        self.output("window.get_position_xy() == %s (tuple)" % ((window_x, window_y),))
        self.output("window.get_position_vector() == %s (Vector2i)" % window.get_position_vector())
        self.output("window.position == %s (tuple)" % (window.position,))
        self.output("There is an x difference of %d and a y difference of %d compared against the last set position of the window. This "
              "inconsistency is a problem when trying to position a window relative to it's current position (e.g. moving horizontally)..." %
              (abs(window_x - x), abs(window_y - x)))
        
        self.output('Random positions for fun..')
        for x in range(20):
            #window.position = randint(1, 640), randint(1, 480)
            self.sleep(0.05)
    
    def example_resize_a_window(self):
        window = self._create_window(b'Example window resizing')
        
        self.output('The size of a window is returned by window.get_size(), window.get_size_xy() and window.size...')
        width, height = window.get_size_xy()
        self.output("window.get_size() == %s (Vector2u)" % window.get_size())
        self.output("window.get_size_xy() == %s (tuple)" % ((width, height),))
        self.output("window.size == %s (tuple)" % (window.size,))
        
        self.output('Windows can be resized by passing a Vector2u object into window.set_size_vector()...')
        for width, height in zip(range(width, width + 50), range(height, height + 50)):
            window.set_size(Vector2u(width, height))
            self.sleep(0.05)
        
        self.output('Windows can also be resized by passing width (x) and height (y) window.set_size_xy(). This is slightly faster...')
        for width, height in zip(range(width, width + 50), range(height, height + 50)):
            window.set_size_xy(width, height)
            self.sleep(0.05)
        
        self.output('window.set_size() accepts both (width, height) tuples and Vector2u objects...')
        
        self.output('Windows can also be resized by assigning a tuple in the form width, height to window.size...')
        for width, height in zip(range(width, width + 50), range(height, height + 50)):
            window.size = width, height
            self.sleep(0.05)
        
        self.output('The width of a window can be altered separately by calling window.set_width()...')
        for width in range(width, width + 50):
            window.set_width(width)
            self.sleep(0.05)
        
        self.output('Width is also defined as a property, window.width...')
        for width in range(width, width + 50):
            window.width = width
            self.sleep(0.05)
        
        self.output('window.set_height()...')
        for height in range(height, height + 50):
            window.set_height(height)
            self.sleep(0.05)
        
        self.output('window.height...')
        for height in range(height, height + 50):
            window.height = height
            self.sleep(0.05)
        
        self.output('Random sizes for fun...')
        for x in range(20):
            window.size = randint(0, 640), randint(0, 480)
            self.sleep(0.05)
    
    def example_window_visibility(self):
        window = self._create_window(b'Example Window Visibility')
        self.output('Window visibility can be changed by calling window.set_visible()...')
        window.set_visible(False)
        self.sleep(1)
        self.output("Let's toggle Window visibility randomly by assigning to the Window.visible property...")
        for x in range(20):
            visible = choice((False, True))
            window.visible = visible
            self.sleep(0.2)
    
    def example_mouse_cursor_visibility(self):
        window = self._create_window(b'Example Window Mouse Cursor Visibility')
        self.output("The mouse cursor when hovering over the window can be set to invisible by calling window.set_mouse_cursor_visible()...")
        window.set_mouse_cursor_visible(False)
        self.sleep(1)
        self.output("Let's make the mouse cursor flash by assigning to the window.mouse_cursor_visible property...")
        for x in range(20):
            window.mouse_cursor_visible = x % 2
            self.sleep(0.2)
    
    def example_set_window_icon(self):
        self.output("Setting the window icon may depend upon retrieving a pixel pointer from a loaded image...")
        return
        window = self._create_window(b'Example Window Icon')
        window.set_icon(32, 32, bytes(bytearray(randint(0, 255) for x in range(32 * 32 * 4))))
        self.sleep(2)
    
    def example_set_window_title(self):
        self.output("Setting window titles after creation is inexplicably broken...")
        return
        window = self._create_window(b'abc')
        window.set_title(b'def')
        self.output("The window title can be set with a bytes object by calling window.set_title()...")
        title = "window.set_title(b'...')"
        for x in range(1, len(title)):
            window.set_title(title[:x])
            self.sleep(0.5)


if __name__ == '__main__':
    example_from_args({
        'python': ExampleWindow,
        #'cython': CExampleWindow,
    }).run()
