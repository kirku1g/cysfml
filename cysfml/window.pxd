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

cdef ContextWrapper Context_create()
cdef ContextWrapper Context_wrap_ptr(cwindow.Context* context_ptr)


cdef class ContextWrapper:
    cdef cwindow.Context* Context
    
    # active
    cpdef set_active(ContextWrapper self, bint active)
    cpdef destroy(ContextWrapper self)


cdef class Context(ContextWrapper):
    pass


# Joystick
################################################################################

cdef Joystick Joystick_create(unsigned int number)


cdef class Joystick:
    cdef unsigned int number
    
    cpdef bint is_connected(Joystick self)
    # button_count
    cpdef unsigned int get_button_count(Joystick self)
    cpdef bint has_axis(Joystick self, cwindow.JoystickAxis axis)
    cpdef bint is_button_pressed(Joystick self, unsigned int button)
    cpdef float axis_position(Joystick self, cwindow.JoystickAxis axis)
    cpdef float axis_name_position(Joystick self, bytes axis_name)


cpdef Joystick_is_connected(unsigned int number)
cpdef Joystick_update()


# Keyboard
################################################################################

cpdef bint Keyboard_is_key_code_pressed(cwindow.KeyCode key_code)
cpdef bint Keyboard_is_key_pressed(bytes key)


# Mouse
################################################################################

cpdef bint Mouse_is_button_code_pressed(cwindow.MouseButton button_code)
cpdef bint Mouse_is_button_pressed(bytes button)


# VideoMode
################################################################################

cdef class VideoModeWrapper:
    cdef cwindow.VideoMode VideoMode
    
    # width
    cpdef unsigned int get_width(VideoModeWrapper self)
    cpdef set_width(VideoModeWrapper self, unsigned int width)
    # height
    cpdef unsigned int get_height(VideoModeWrapper self)
    cpdef set_height(VideoModeWrapper self, unsigned int height)
    # bits_per_pixel
    cpdef unsigned int get_bits_per_pixel(VideoModeWrapper self)
    cpdef set_bits_per_pixel(VideoModeWrapper self, unsigned int bits_per_pixel)
    # valid
    cpdef bint is_valid(VideoModeWrapper self)


cdef class VideoMode(VideoModeWrapper):
    pass


cdef VideoModeWrapper VideoMode_wrap(cwindow.VideoMode video_mode_struct)
cpdef VideoModeWrapper desktop_mode()
cpdef list fullscreen_modes()


# ContextSettings
#################

cpdef cwindow.ContextSettings ContextSettings(
        unsigned int depth_bits=*,
        unsigned int stencil_bits=*,
        unsigned int antialiasing_level=*,
        unsigned int major_version=*,
        unsigned int minor_version=*)


# Window
########

cdef WindowWrapper Window_wrap_ptr(cwindow.Window* window_ptr)
cdef WindowWrapper Window_create(
            VideoMode video_mode,
            const char* title,
            int style=*,
            cwindow.ContextSettings context_settings=*)


cdef class WindowWrapper:
    cdef cwindow.Window* Window
    
    # open
    cpdef bint is_open(WindowWrapper self)
    # settings
    cpdef cwindow.ContextSettings get_settings(WindowWrapper self)
    # position
    cpdef tuple get_position(WindowWrapper self)
    cpdef csystem.Vector2i get_position_vector(WindowWrapper self)
    cpdef tuple get_position_xy(WindowWrapper self)
    cpdef set_position(WindowWrapper self, position)
    cpdef set_position_xy(WindowWrapper self, int x, int y)
    cpdef set_position_vector(WindowWrapper self, csystem.Vector2i position)
    # size
    cpdef tuple get_size(WindowWrapper self)
    cpdef csystem.Vector2u get_size_vector(WindowWrapper self)
    cpdef tuple get_size_xy(WindowWrapper self)
    cpdef set_size(WindowWrapper self, size)
    cpdef set_size_vector(WindowWrapper self, csystem.Vector2u size)
    cpdef set_size_xy(WindowWrapper self, unsigned int x, unsigned int y)
    # x
    cpdef int get_x(WindowWrapper self)
    cpdef set_x(WindowWrapper self, int x)
    # y
    cpdef int get_y(WindowWrapper self)
    cpdef set_y(WindowWrapper self, int y)
    # width
    cpdef int get_width(WindowWrapper self)
    cpdef set_width(WindowWrapper self, unsigned int width)
    # height
    cpdef int get_height(WindowWrapper self)
    cpdef set_height(WindowWrapper self, unsigned int height)
    # title
    cpdef set_title(WindowWrapper self, const char* title)
    # unicode_title
    cpdef set_unicode_title(WindowWrapper self, str title)
    # icon
    cpdef set_icon(WindowWrapper self, unsigned int width, unsigned int height, Uint8* pixels)
    # visible
    cpdef set_visible(WindowWrapper self, bint visible)
    # mouse_cursor_visible
    cpdef set_mouse_cursor_visible(WindowWrapper self, bint visible)
    # vsync
    cpdef set_vsync(WindowWrapper self, bint enabled)
    # key_repeat
    cpdef set_key_repeat(WindowWrapper self, bint enabled)
    # active
    cpdef set_active(WindowWrapper self, bint active)
    # framerate_limit
    cpdef set_framerate_limit(WindowWrapper self, unsigned int limit)
    # joystick_threshold
    cpdef set_joystick_threshold(WindowWrapper self, float threshold)
    # Cython methods
    cpdef close(WindowWrapper self)
    cpdef destroy(WindowWrapper self)
    cpdef display(WindowWrapper self)


cdef class Window(WindowWrapper):
    pass

