from config cimport (
    Uint8,
    Uint32,
)
cimport csystem
cimport system

cimport cwindow

cimport utils


# Context
################################################################################

cdef ContextWrapper Context_create():
    return Context_wrap_ptr(cwindow.Context_create())


cdef ContextWrapper Context_wrap_ptr(cwindow.Context* context_ptr):
    cdef ContextWrapper context = ContextWrapper()
    context.Context = context_ptr
    return context


cdef class ContextWrapper:
    
    # active
    
    cpdef set_active(ContextWrapper self, bint active):
        cwindow.Context_set_active(self.Context, active)
    
    property active:
        def __set__(ContextWrapper self, bint active):
            cwindow.Context_set_active(self.Context, active)
    
    # Cython methods
    
    cpdef destroy(ContextWrapper self):
        cwindow.Context_destroy(self.Context)
    
    # Special methods
    
    def __dealloc__(ContextWrapper self):
        cwindow.Context_destroy(self.Context)


cdef class Context(ContextWrapper):
    def __cinit__(ContextWrapper self):
        self.Context = cwindow.Context_create()


# Joystick
################################################################################

JOYSTICK_COUNT = cwindow.JOYSTICK_COUNT
JOYSTICK_BUTTON_COUNT = cwindow.JOYSTICK_BUTTON_COUNT
JOYSTICK_AXIS_COUNT = cwindow.JOYSTICK_AXIS_COUNT

JOYSTICK_AXIS_NAMES = (
    b'X',
    b'Y',
    b'Z',
    b'R',
    b'U',
    b'V',
    b'PovX',
    b'PovY',
)

JOYSTICK_AXIS_CODES = dict(enumerate(JOYSTICK_AXIS_NAMES))


cdef Joystick Joystick_create(unsigned int number):
    return Joystick(number)


cdef class Joystick:
    def __cinit__(Joystick self, unsigned int number):
        self.number = number
    
    # connected
    
    cpdef bint is_connected(Joystick self):
        return cwindow.Joystick_is_connected(self.number)
    
    property connected:
        def __get__(Joystick self):
            return self.is_connected()
    
    # button_count
    
    cpdef unsigned int get_button_count(Joystick self):
        return cwindow.Joystick_get_button_count(self.number)
    
    property button_count:
        def __get__(Joystick self):
            return self.get_button_count()
    
    cpdef bint has_axis(Joystick self, cwindow.JoystickAxis axis):
        return cwindow.Joystick_has_axis(self.number, axis)
    
    cpdef bint is_button_pressed(Joystick self, unsigned int button):
        return cwindow.Joystick_is_button_pressed(self.nuber, button)
    
    cpdef float axis_position(Joystick self, cwindow.JoystickAxis axis):
        return cwindow.Joystick_get_axis_position(self.number, axis)
    
    cpdef float axis_name_position(Joystick self, bytes axis_name):
        return self.axis_position(JOYSTICK_AXIS_CODES[axis_name])
    
    def __richcmp__(Joystick self, other, int op):
        if not isinstance(other, Joystick):
            return False
        
        return utils.richcmp_unsigned_ints(self.number, other.number, op)


cpdef Joystick_is_connected(unsigned int number):
    return cwindow.Joystick_is_connected(number)


cpdef Joystick_update():
    cwindow.Joystick_update()


# Keyboard
################################################################################

# TODO: Change names to be consistent.
# TODO: Find better way of exposing key codes.
KEY_NAMES = (
    b'A',
    b'B',
    b'C',
    b'D',
    b'E',
    b'F',
    b'G',
    b'H',
    b'I',
    b'J',
    b'K',
    b'L',
    b'M',
    b'N',
    b'O',
    b'P',
    b'Q',
    b'R',
    b'S',
    b'T',
    b'U',
    b'V',
    b'W',
    b'Y',
    b'X',
    b'Z',
    b'0',
    b'1',
    b'2',
    b'3',
    b'4',
    b'5',
    b'6',
    b'7',
    b'8',
    b'9',
    b'Escape',
    b'LControl',     # The left Control key
    b'LShift',       # The left Shift key
    b'LAlt',         # The left Alt key
    b'LSystem',      # The left OS specific key: window (Windows and Linux) apple (MacOS X) ...
    b'RControl',     # The right Control key
    b'RShift',       # The right Shift key
    b'RAlt',         # The right Alt key
    b'RSystem',      # The right OS specific key: window (Windows and Linux) apple (MacOS X) ...
    b'Menu',         # The Menu key
    b'LBracket',     # The [ key
    b'RBracket',     # The ] key
    b'SemiColon',    # The ; key
    b'Comma',        # The  key
    b'Period',       # The . key
    b'Quote',        # The ' key
    b'Slash',        # The / key
    b'BackSlash',    # The \ key
    b'Tilde',        # The ~ key
    b'Equal',        # The = key
    b'Dash',         # The - key
    b'Space',        # The Space key
    b'Return',       # The Return key
    b'Back',         # The Backspace key
    b'Tab',          # The Tabulation key
    b'PageUp',       # The Page up key
    b'PageDown',     # The Page down key
    b'End',          # The End key
    b'Home',         # The Home key
    b'Insert',       # The Insert key
    b'Delete',       # The Delete key
    b'Add',          # +
    b'Subtract',     # -
    b'Multiply',     # *
    b'Divide',       # /
    b'Left',         # Left arrow
    b'Right',        # Right arrow
    b'Up',           # Up arrow
    b'Down',         # Down arrow
    b'Numpad0',      # The numpad 0 key
    b'Numpad1',      # The numpad 1 key
    b'Numpad2',      # The numpad 2 key
    b'Numpad3',      # The numpad 3 key
    b'Numpad4',      # The numpad 4 key
    b'Numpad5',      # The numpad 5 key
    b'Numpad6',      # The numpad 6 key
    b'Numpad7',      # The numpad 7 key
    b'Numpad8',      # The numpad 8 key
    b'Numpad9',      # The numpad 9 key
    b'F1',           # The F1 key
    b'F2',           # The F2 key
    b'F3',           # The F3 key
    b'F4',           # The F4 key
    b'F5',           # The F5 key
    b'F6',           # The F6 key
    b'F7',           # The F7 key
    b'F8',           # The F8 key
    b'F9',           # The F8 key
    b'F10',          # The F10 key
    b'F11',          # The F11 key
    b'F12',          # The F12 key
    b'F13',          # The F13 key
    b'F14',          # The F14 key
    b'F15',          # The F15 key
    b'Pause',        # The Pause key
)

KEY_CODES = {}
KEY_NAME_LOOKUP = {}

cdef:
    unsigned int index
    bytes key_name

for index, key_name in enumerate(KEY_NAMES):
    KEY_CODES[key_name] = index
    KEY_NAME_LOOKUP[index] = key_name


cpdef bint Keyboard_is_key_code_pressed(cwindow.KeyCode key_code):
    return cwindow.Keyboard_is_key_pressed(key_code)


cpdef bint Keyboard_is_key_pressed(bytes key):
    return cwindow.Keyboard_is_key_pressed(KEY_CODES[key])


# Mouse
################################################################################

MOUSE_BUTTON_NAMES = (
    b'MOUSE_BUTTON_LEFT',
    b'MOUSE_BUTTON_RIGHT',
    b'MOUSE_BUTTON_MIDDLE',
    b'MOUSE_BUTTON_X1',
    b'MOUSE_BUTTON_X2',
)


MOUSE_BUTTON_CODES = {}
MOUSE_BUTTON_NAME_LOOKUP = {}

cdef bytes mouse_button_name

for index, mouse_button_name in enumerate(MOUSE_BUTTON_NAMES):
    MOUSE_BUTTON_CODES[mouse_button_name] = index
    MOUSE_BUTTON_NAME_LOOKUP[index] = mouse_button_name


cpdef bint Mouse_is_button_code_pressed(cwindow.MouseButton button_code):
    return cwindow.Mouse_is_button_pressed(button_code)


cpdef bint Mouse_is_button_pressed(bytes button):
    return cwindow.Mouse_is_button_pressed(MOUSE_BUTTON_CODES[button])


# VideoMode
################################################################################


cdef class VideoModeWrapper:
    
    # width
    
    cpdef unsigned int get_width(VideoModeWrapper self):
        return self.VideoMode.width
    
    cpdef set_width(VideoModeWrapper self, unsigned int width):
        self.VideoMode.width = width
    
    property width:
        def __get__(VideoModeWrapper self):
            return self.VideoMode.width
        
        def __set__(VideoModeWrapper self, unsigned int width):
            self.VideoMode.width = width
    
    # height
    
    cpdef unsigned int get_height(VideoModeWrapper self):
        return self.VideoMode.height
    
    cpdef set_height(VideoModeWrapper self, unsigned int height):
        self.VideoMode.height = height
    
    property height:
        def __get__(VideoModeWrapper self):
            return self.VideoMode.height
        
        def __set__(VideoModeWrapper self, unsigned int height):
            self.VideoMode.height = height
    
    # bits_per_pixel
    
    cpdef unsigned int get_bits_per_pixel(VideoModeWrapper self):
        return self.VideoMode.bits_per_pixel
    
    cpdef set_bits_per_pixel(VideoModeWrapper self, unsigned int bits_per_pixel):
        self.VideoMode.bits_per_pixel = bits_per_pixel
    
    property bits_per_pixel:
        def __get__(VideoModeWrapper self):
            return self.VideoMode.bits_per_pixel
        
        def __set__(VideoModeWrapper self, unsigned int bits_per_pixel):
            self.VideoMode.bits_per_pixel = bits_per_pixel
    
    # valid
    
    cpdef bint is_valid(VideoModeWrapper self):
        return cwindow.VideoMode_is_valid(self.VideoMode)
    
    property valid:
        def __get__(VideoModeWrapper self):
            return self.is_valid()
    
    # Special methods
    
    def __str__(VideoModeWrapper self):
        return '%dx%d:%d' % (
            self.VideoMode.width,
            self.VideoMode.height,
            self.VideoMode.bits_per_pixel,
        )
    
    def __repr__(VideoModeWrapper self):
        return 'VideoMode(%d, %d, %d)' % (
            self.VideoMode.width,
            self.VideoMode.height,
            self.VideoMode.bits_per_pixel,
        )
    
    def __richcmp__(VideoModeWrapper self, other, int op):
        if not isinstance(other, VideoModeWrapper):
            return False # TODO: Compare against tuple?
        
        return (utils.richcmp_unsigned_ints(self.get_width(), other.get_width(), op) and
                utils.richcmp_unsigned_ints(self.get_height(), other.get_height(), op) and
                utils.richcmp_unsigned_ints(self.get_bits_per_pixel(), other.get_bits_per_pixel(), op))


cdef class VideoMode(VideoModeWrapper):
    def __init__(
            VideoMode self,
            unsigned int width,
            unsigned int height,
            unsigned int bits_per_pixel):
        cdef cwindow.VideoMode video_mode
        video_mode.width = width
        video_mode.height = height
        video_mode.bits_per_pixel = bits_per_pixel
        self.VideoMode = video_mode


cdef VideoModeWrapper VideoMode_wrap(cwindow.VideoMode video_mode_struct): 
    cdef VideoModeWrapper video_mode = VideoModeWrapper()
    video_mode.VideoMode = video_mode_struct
    return video_mode


cpdef VideoModeWrapper desktop_mode():
    return VideoMode_wrap(cwindow.VideoMode_get_desktop_mode())


cpdef list fullscreen_modes():
    cdef list video_modes_list = []
    cdef size_t count, index
    cdef cwindow.VideoMode* video_modes = cwindow.VideoMode_get_fullscreen_modes(&count)
    for index in range(count):
        video_modes_list.append(VideoMode_wrap(video_modes[index]))
    return video_modes_list


# ContextSettings
#################

cpdef cwindow.ContextSettings ContextSettings(
        unsigned int depth_bits=0,
        unsigned int stencil_bits=0,
        unsigned int antialiasing_level=0,
        unsigned int major_version=2,
        unsigned int minor_version=0):
    cdef cwindow.ContextSettings context_settings
    context_settings.depth_bits = depth_bits
    context_settings.stencil_bits = stencil_bits
    context_settings.antialiasing_level = antialiasing_level
    context_settings.major_version = major_version
    context_settings.minor_version = minor_version
    return context_settings


# Window
########

WINDOW_STYLE_NONE = cwindow.WINDOW_STYLE_NONE
WINDOW_STYLE_TITLEBAR = cwindow.WINDOW_STYLE_TITLEBAR
WINDOW_STYLE_RESIZE = cwindow.WINDOW_STYLE_RESIZE
WINDOW_STYLE_CLOSE = cwindow.WINDOW_STYLE_CLOSE
WINDOW_STYLE_FULLSCREEN = cwindow.WINDOW_STYLE_FULLSCREEN
WINDOW_STYLE_DEFAULT = cwindow.WINDOW_STYLE_DEFAULT


cdef WindowWrapper Window_wrap_ptr(cwindow.Window* window_ptr):
    cdef WindowWrapper window = Window()
    window.Window = window_ptr
    return window


cdef WindowWrapper Window_create(
            VideoMode video_mode,
            const char* title,
            int style=cwindow.WINDOW_STYLE_DEFAULT,
            cwindow.ContextSettings context_settings=ContextSettings()):
    return Window_wrap_ptr(cwindow.Window_create(
        video_mode.VideoMode,
        title,
        style,
        &context_settings,
    ))


cdef class WindowWrapper:
    # TODO: Support unicode title and from window handle.

    # open
    
    cpdef bint is_open(WindowWrapper self):
        return cwindow.Window_is_open(self.Window)
    
    property open:
        def __get__(WindowWrapper self):
            return cwindow.Window_is_open(self.Window)
    
    # settings
    
    cpdef cwindow.ContextSettings get_settings(WindowWrapper self):
        return cwindow.Window_get_settings(self.Window)
    
    property settings:
        def __get__(WindowWrapper self):
            return self.get_settings()
    
    ## events
    
    #cpdef handle_event(WindowWrapper self, Event event):
        #pass
    
    #cpdef Event poll_event(WindowWrapper self):
        #cdef cwindow.Event event
        #cdef bint event_exists = cwindow.Window_poll_event(self.Window, &event)
        #if event_exists:
            #return create_event(event)
        #else:
            #raise LookupError
    
    #cpdef poll_events(WindowWrapper self):
        #'''
        #TODO: Find way to only use last MoveEvent
        #TODO: Check if loop is any faster than calling poll_event repeatedly.
        #'''
        ##cdef list events = []
        #cdef bint event_exists = True
        #cdef cwindow.Event event
        #cdef bint mouse_move_event_exists = False
        #cdef cwindow.Event mouse_move_event
        #while event_exists:
            #event_exists = cwindow.Window_poll_event(self.Window, &event)
            #if event.type == cwindow.EVENT_MOUSE_MOVED and self.limit_move_events:
                #mouse_move_event = event
                #mouse_move_event_exists = True
                #continue
            #self.handle_event(create_event(event))
        #if mouse_move_event_exists:
            #self.handle_event(create_event(mouse_move_event))
    
    #cpdef Event wait_event(WindowWrapper self):
        #cdef cwindow.Event event
        #cdef bint event_exists = cwindow.Window_wait_event(self.Window, &event)
        #if event_exists:
            #return create_event(event)
        #else:
            #raise LookupError
    
    # position
    
    cpdef tuple get_position(WindowWrapper self):
        return system.Vector2i_unpack(cwindow.Window_get_position(self.Window))
    
    cpdef csystem.Vector2i get_position_vector(WindowWrapper self):
        return cwindow.Window_get_position(self.Window)
    
    cpdef tuple get_position_xy(WindowWrapper self):
        '''
        Duplicate of get_position.
        '''
        return system.Vector2i_unpack(cwindow.Window_get_position(self.Window))
    
    cpdef set_position(WindowWrapper self, position):
        cwindow.Window_set_position(self.Window, system.Vector2i_cast(position))
    
    cpdef set_position_xy(WindowWrapper self, int x, int y):
        cwindow.Window_set_position(self.Window, system.Vector2i(x, y))
    
    cpdef set_position_vector(WindowWrapper self, csystem.Vector2i position):
        cwindow.Window_set_position(self.Window, position)
    
    property position:
        def __get__(WindowWrapper self):
            return self.get_position()
        
        def __set__(WindowWrapper self, position):
            self.set_position(position)
    
    # size
    
    cpdef tuple get_size(WindowWrapper self):
        return system.Vector2u_unpack(cwindow.Window_get_size(self.Window))
    
    cpdef csystem.Vector2u get_size_vector(WindowWrapper self):
        return cwindow.Window_get_size(self.Window)
        
    cpdef tuple get_size_xy(WindowWrapper self):
        '''
        Duplicate of get_position.
        '''
        return system.Vector2u_unpack(cwindow.Window_get_size(self.Window))
    
    cpdef set_size(WindowWrapper self, size):
        cwindow.Window_set_size(self.Window, system.Vector2u_cast(size))
    
    cpdef set_size_vector(WindowWrapper self, csystem.Vector2u size):
        cwindow.Window_set_size(self.Window, size)
    
    cpdef set_size_xy(WindowWrapper self, unsigned int x, unsigned int y):
        cwindow.Window_set_size(self.Window, system.Vector2u(x, y))
    
    property size:
        def __get__(WindowWrapper self):
            return self.get_size()
        
        def __set__(WindowWrapper self, size):
            self.set_size(size)
    
    # x
    
    # The following methods do not act as expected since the position returned
    # by get_position() depends on the Window decoration.
    cpdef int get_x(WindowWrapper self):
        return self.get_position_vector().x
    
    cpdef set_x(WindowWrapper self, int x):
        cdef csystem.Vector2i position = self.get_position_vector()
        position.x = x
        self.set_position_vector(position)
    
    property x:
        def __get__(WindowWrapper self):
            return self.get_x()
        
        def __set__(WindowWrapper self, int x):
            self.set_x(x)
    
    # y
    
    cpdef int get_y(WindowWrapper self):
        return self.get_position_vector().y
    
    cpdef set_y(WindowWrapper self, int y):
        cdef csystem.Vector2i position = self.get_position_vector()
        position.y = y
        self.set_position_vector(position)
    
    property y:
        def __get__(WindowWrapper self):
            return self.get_y()
        
        def __set__(WindowWrapper self, int y):
            self.set_y(y)
    
    # width
    
    cpdef int get_width(WindowWrapper self):
        return self.get_size_vector().width
    
    cpdef set_width(WindowWrapper self, unsigned int width):
        cdef csystem.Vector2u size = self.get_size_vector()
        size.x = width
        self.set_size_vector(size)
    
    property width:
        def __get__(WindowWrapper self):
            return self.get_width()
        
        def __set__(WindowWrapper self, unsigned int width):
            self.set_width(width)
    
    # height
    
    cpdef int get_height(WindowWrapper self):
        return self.get_size_vector().height
    
    cpdef set_height(WindowWrapper self, unsigned int height):
        cdef csystem.Vector2u size = self.get_size_vector()
        size.y = height
        self.set_size_vector(size)
    
    property height:
        def __get__(WindowWrapper self):
            return self.get_height()
        
        def __set__(WindowWrapper self, unsigned int height):
            self.set_height(height)
    
    # title
    
    cpdef set_title(WindowWrapper self, const char* title):
        cwindow.Window_set_title(self.Window, title)
    
    property title:
        def __set__(WindowWrapper self, const char* title):
            self.set_title(title)
    
    # unicode_title
    
    cpdef set_unicode_title(WindowWrapper self, str title):
        # Q: Does this work?
        py_title = title.encode('utf-32-le')
        cdef char* c_title = py_title
        c_string = <unsigned int*>c_title
        cwindow.Window_set_unicode_title(self.Window, c_string)
    
    property unicode_title:
        def __set__(WindowWrapper self, str title):
            self.set_unicode_title(title)
    
    # icon
    
    cpdef set_icon(WindowWrapper self, unsigned int width, unsigned int height, Uint8* pixels):
        cwindow.Window_set_icon(self.Window, width, height, pixels)
    
    # visible
    
    cpdef set_visible(WindowWrapper self, bint visible):
        cwindow.Window_set_visible(self.Window, visible)
    
    property visible:
        def __set__(WindowWrapper self, bint visible):
            self.set_visible(visible)
    
    # mouse_cursor_visible
    
    cpdef set_mouse_cursor_visible(WindowWrapper self, bint visible):
        cwindow.Window_set_mouse_cursor_visible(self.Window, visible)
    
    property mouse_cursor_visible:
        def __set__(WindowWrapper self, bint visible):
            self.set_mouse_cursor_visible(visible)
    
    # vsync
    
    cpdef set_vsync(WindowWrapper self, bint enabled):
        cwindow.Window_set_vertical_sync_enabled(self.Window, enabled)
    
    property vsync:
        def __set__(WindowWrapper self, bint vsync):
            self.set_vsync(vsync)
    
    # key_repeat
    
    cpdef set_key_repeat(WindowWrapper self, bint enabled):
        cwindow.Window_set_key_repeat_enabled(self.Window, enabled)
    
    property key_repeat:
        def __set__(WindowWrapper self, bint key_repeat):
            self.set_key_repeat(key_repeat)
    
    # active
    
    cpdef set_active(WindowWrapper self, bint active):
        cwindow.Window_set_active(self.Window, active)
    
    property active:
        def __set__(WindowWrapper self, bint active):
            self.set_active(active)
    
    # framerate_limit
    
    cpdef set_framerate_limit(WindowWrapper self, unsigned int limit):
        cwindow.Window_set_framerate_limit(self.Window, limit)
    
    property framerate_limit:
        def __set__(WindowWrapper self, unsigned int limit):
            self.set_framerate_limit(limit)
    
    # joystick_threshold
    
    cpdef set_joystick_threshold(WindowWrapper self, float threshold):
        cwindow.Window_set_joystick_threshold(self.Window, threshold)
    
    property joystick_threshold:
        def __set__(WindowWrapper self, float threshold):
            self.set_joystick_threshold(threshold)
    
    # Cython methods
    
    cpdef close(WindowWrapper self):
        cwindow.Window_close(self.Window)
    
    cpdef destroy(WindowWrapper self):
        cwindow.Window_destroy(self.Window)
    
    cpdef display(WindowWrapper self):
        cwindow.Window_display(self.Window)
    
    # Special methods
    
    def __dealloc__(WindowWrapper self):
        cwindow.Window_destroy(self.Window)
    
    # TODO:
    
    #cpdef cwindow.WindowHandle get_system_handle(WindowWrapper self):
        #return cwindow.Window_get_system_handle(self.Window)


cdef class Window(WindowWrapper):
    def __init__(
            Window self,
            VideoMode video_mode,
            const char* title,
            int style=cwindow.WINDOW_STYLE_DEFAULT,
            cwindow.ContextSettings context_settings=ContextSettings()):
        self.Window = cwindow.Window_create(
            video_mode.VideoMode,
            title,
            style,
            &context_settings,
        )


## Event
#################################################################################

#cdef class Event:
    #pass


#cdef class ClosedEvent(Event):
    #pass


#cdef class ResizedEvent(Event):
    #pass


#cdef class LostFocusEvent(Event):
    #pass


#cdef class GainedFocusEvent(Event):
    #pass


## KeyEvent
#################################################################################

#cdef class KeyEvent(Event):
    #def __cinit__(Event self, cwindow.KeyEvent event):
        #self.event = event


#cdef class KeyPressedEvent(KeyEvent):
    #pass


#cdef class KeyReleasedEvent(KeyEvent):
    #pass


## TextEvent
#################################################################################

#cdef class TextEnteredEvent(Event):
    #def __cinit__(Event self, cwindow.TextEvent event):
        #self.event = event


##

#cdef class MouseMoveEvent(Event):
    #def __cinit__(Event self, cwindow.MouseMoveEvent event):
        #self.event = event


## MouseButtonEvent
#################################################################################

#cdef class MouseButtonEvent(Event):
    #def __cinit__(Event self, cwindow.MouseButtonEvent event):
        #self.event = event

#cdef class MouseButtonPressedEvent(MouseButtonEvent):
    #pass


#cdef class MouseButtonReleasedEvent(MouseButtonEvent):
    #pass


##


#cdef class MouseWheelMovedEvent(Event):
    #def __cinit__(Event self, cwindow.MouseWheelEvent event):
        #self.event = event


#cdef class MouseEnteredEvent(Event):
    #pass


#cdef class MouseLeftEvent(Event):
    #pass


#cdef class JoystickMovedEvent(Event):
    #def __cinit__(Event self, cwindow.JoystickMoveEvent event):
        #self.event = event


## JoystickButtonEvent

#cdef class JoystickButtonEvent(Event):
    #def __cinit__(Event self, cwindow.JoystickButtonEvent event):
        #self.event = event


#cdef class JoystickButtonPressedEvent(JoystickButtonEvent):
    #pass


#cdef class JoystickButtonReleasedEvent(JoystickButtonEvent):
    #pass


## JoystickConnectEvent
#################################################################################

#cdef class JoystickConnectEvent(Event):
    #def __cinit__(Event self, cwindow.JoystickConnectEvent event):
        #self.event = event


#cdef class JoystickConnectedEvent(JoystickConnectEvent):
    #pass


#cdef class JoystickDisconnectedEvent(JoystickConnectEvent):
    #pass


## SizeEvent
#################################################################################

#cdef class ResizeEvent(Event):
    #def __cinit__(Event self, cwindow.SizeEvent event):
        #self.event = event


#cpdef Event create_event(cwindow.Event event):
    ## OPT: Ordered so that most frequent events are at the top.
    #if event.type == cwindow.EVENT_MOUSE_MOVED:
        #return MouseMoveEvent(event.mouse_move)
    #elif event.type == cwindow.EVENT_KEY_PRESSED:
        #return KeyPressedEvent(event.key)
    #elif event.type == cwindow.EVENT_KEY_RELEASED:
        #return KeyReleasedEvent(event.key)
    #elif event.type == cwindow.EVENT_MOUSE_BUTTON_PRESSED:
        #return MouseButtonPressedEvent(event.mouse_button)
    #elif event.type == cwindow.EVENT_MOUSE_BUTTON_RELEASED:
        #return MouseButtonReleasedEvent(event.mouse_button)
    #elif event.type == cwindow.EVENT_MOUSE_WHEEL_MOVED:
        #return MouseWheelMovedEvent(event.mouse_wheel)
    #elif event.type == cwindow.EVENT_JOYSTICK_MOVED:
        #return JoystickMovedEvent(event.joystick_move)
    #elif event.type == cwindow.EVENT_MOUSE_ENTERED:
        #return MouseEnteredEvent()
    #elif event.type == cwindow.EVENT_MOUSE_LEFT:
        #return MouseLeftEvent()
    #elif event.type == cwindow.EVENT_JOYSTICK_BUTTON_PRESSED:
        #return JoystickButtonPressedEvent()
    #elif event.type == cwindow.EVENT_JOYSTICK_BUTTON_RELEASED:
        #return JoystickButtonReleasedEvent()
    #elif event.type == cwindow.EVENT_LOST_FOCUS:
        #return LostFocusEvent()
    #elif event.type == cwindow.EVENT_GAINED_FOCUS:
        #return GainedFocusEvent()
    #elif event.type == cwindow.EVENT_RESIZED:
        #return ResizedEvent()
    #elif event.type == cwindow.EVENT_CLOSED:
        #return ClosedEvent()
    #elif event.type == cwindow.EVENT_JOYSTICK_CONNECTED:
        #return JoystickConnectedEvent()
    #elif event.type == cwindow.EVENT_JOYSTICK_DISCONNECTED:
        #return JoystickDisconnectedEvent()