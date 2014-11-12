from libc.stdlib cimport rand

from example cimport Example
from csystem cimport (
    Vector2u,
)
from system cimport (
    create_vector2i,
    create_vector2u,
)

from window cimport (
    VideoMode,
    Window,
    create_video_mode,
    create_window,
)


cdef class ExampleWindow(Example):
    
    cpdef _run(ExampleWindow self):
        self.example_create_a_window()
        self.example_mouse_cursor_visibility()
        self.example_position_a_window()
        self.example_resize_a_window()
        self.example_window_visibility()
    
    cdef Window _create_window(ExampleWindow self, char* name):
        cdef VideoMode video_mode = create_video_mode(320, 240, 32)
        return create_window(video_mode, name)
    
    cdef example_create_a_window(ExampleWindow self):
        self.output('Create a window by calling graphics.create_window()...')
        cdef Window window = self._create_window(b'Example Window')
        self.output('Check if a window is open by calling window.is_open()...')
        self.output('window.is_open() == %s...' % window.is_open())
        self.sleep(2)
        self.output('The window can be closed by calling window.close()')
        window.close()
        self.sleep(0.5)
        self.output('The window is also closed (deallocated) when the object falls out of scope...')
    
    cdef example_position_a_window(ExampleWindow self):
        cdef Window window = self._create_window(b'Example Window Positioning')
        window.set_mouse_cursor_visible(False)
        self.output('Windows can be positioned with a Vector2i object using window.set_position()...')
        cdef int x
        for x in range(50):
            window.set_position(create_vector2i(x, x))
            self.sleep(0.05)
        
        self.output('Windows can also be positioned with x and y co-ordinates object using window.set_position_xy()...')
        for x in range(x, x + 50):
            window.set_position_xy(x, x)
            self.sleep(0.05)
        
        self.output('Windows can also be positioned by assigning an x, y tuple to the position property. This introduces some Python overhead...')
        for x in range(x, x + 50):
            window.position = x, x
            self.sleep(0.05)
        
        self.output("Strangely, get_position() returns a window position that is offset by window borders...")
        window_x, window_y = window.get_position_xy()
        self.output("window.get_position() == %s (Vector2i)" % window.get_position())
        self.output("window.get_position_xy() == %s (tuple)" % ((window_x, window_y),))
        self.output("window.position == %s (tuple)" % (window.position,))
        self.output("There is an x difference of %d and a y difference of %d compared against the last set position of the window. This "
              "inconsistency is a problem when trying to position a window relative to it's current position (e.g. moving horizontally)..." %
              (abs(window_x - x), abs(window_y - x)))
        
        self.output('Random positions for fun..')
        for x in range(20):
            window.position = rand() % 640, rand() % 480
            self.sleep(0.05)
    
    cdef example_resize_a_window(ExampleWindow self):
        cdef Window window = self._create_window(b'Example window resizing')
        
        self.output('The size of a window is returned by window.get_size(), window.get_size_xy() and window.size...')
        cdef:
            Vector2u vector = window.get_size()
            unsigned int width = vector.x
            unsigned int height = vector.y
            int x
        self.output("window.get_size() == %s (Vector2u - fastest)" % window.get_size())
        self.output("window.get_size_xy() == %s (tuple)" % ((width, height),))
        self.output("window.size == %s (tuple)" % (window.size,))
        
        self.output('Windows can be resized by passing a Vector2u object into window.set_size()...')
        for x in range(50):
            width += 1
            height += 1
            window.set_size(create_vector2u(width, height))
            self.sleep(0.05)
        
        self.output('Windows can also be resized by passing width (x) and height (y) window.set_size_xy()...')
        for x in range(50):
            width += 1
            height += 1
            window.set_size_xy(width, height)
            self.sleep(0.05)
        
        self.output('Windows can also be resized by assigning a tuple in the form width (x), height (y) to window.size. This introduces some Python overhead...')
        for x in range(50):
            width += 1
            height += 1
            window.size = width, height
            self.sleep(0.05)
        
        self.output('The width of a window can be altered separately by calling window.set_width()...')
        for width in range(width, width + 50):
            window.set_width(width)
            self.sleep(0.05)
        
        self.output('Width is also defined as a property, window.width. This introduces some Python overhead...')
        for width in range(width, width + 50):
            window.width = width
            self.sleep(0.05)
        
        self.output('window.set_height()...')
        for height in range(height, height + 50):
            window.set_height(height)
            self.sleep(0.05)
        
        self.output('window.height. This introduces some Python overhead...')
        for height in range(height, height + 50):
            window.height = height
            self.sleep(0.05)
        
        self.output('Random sizes for fun...')
        for x in range(20):
            window.size = rand() % 640, rand() % 480
            self.sleep(0.05)
    
    cdef example_window_visibility(ExampleWindow self):
        cdef Window window = self._create_window(b'Example Window Visibility')
        self.output('Window visibility can be changed by calling window.set_visible()...')
        window.set_visible(False)
        self.sleep(1)
        self.output("Let's toggle Window visibility by assigning to the Window.visible property. This introduces some Python overhead...")
        cdef int x
        for x in range(20):
            window.visible = x % 2
            self.sleep(0.2)
    
    cdef example_mouse_cursor_visibility(ExampleWindow self):
        cdef Window window = self._create_window(b'Example Window Mouse Cursor Visibility')
        self.output("The mouse cursor when hovering over the window can be set to invisible by calling window.set_mouse_cursor_visible()...")
        window.set_mouse_cursor_visible(False)
        self.sleep(1)
        self.output("Let's make the mouse cursor flash by assigning to the window.mouse_cursor_visible property. This introduces some Python overhead...")
        cdef int x
        for x in range(20):
            window.mouse_cursor_visible = x % 2
            self.sleep(0.2)
    
    cdef example_set_window_title(ExampleWindow self):
        self.output("Setting window titles after creation is inexplicably broken...")
        return
        cdef Window window = self._create_window(b'abc')
        window.set_title(b'def')
        self.output("The window title can be set with a bytes object by calling window.set_title()...")
        title = "window.set_title(b'...')"
        for x in range(1, len(title)):
            window.set_title(title[:x])
            self.sleep(0.5)
    
