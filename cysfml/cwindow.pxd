from config cimport (
    Uint32
)
from csystem cimport (
    Vector2i,
    Vector2u,
)


# SFML/Window/Types.h
################################################################################

cdef extern from 'SFML/Window/Types.h' nogil:
    ctypedef struct Context 'sfContext'
    ctypedef struct Window 'sfWindow'


# SFML/Window/Context.h
################################################################################

cdef extern from 'SFML/Window/Context.h' nogil:
    cdef Context* Context_create 'sfContext_create' ()
    cdef void Context_destroy 'sfContext_destroy' (Context* context)
    cdef void Context_set_active 'sfContext_setActive' (Context* context, bint active)


# SFML/Window/Keyboard.h
################################################################################

cdef extern from 'SFML/Window/Keyboard.h' nogil:
    ctypedef enum KeyCode 'sfKeyCode':
        KEY_UNKNOWN 'sfKeyUnknown' = -1 # Unhandled key
        KEY_A 'sfKeyA'            # The A key
        KEY_B 'sfKeyB'            # The B key
        KEY_C 'sfKeyC'            # The C key
        KEY_D 'sfKeyD'            # The D key
        KEY_E 'sfKeyE'            # The E key
        KEY_F 'sfKeyF'            # The F key
        KEY_G 'sfKeyG'            # The G key
        KEY_H 'sfKeyH'            # The H key
        KEY_I 'sfKeyI'            # The I key
        KEY_J 'sfKeyJ'            # The J key
        KEY_K 'sfKeyK'            # The K key
        KEY_L 'sfKeyL'            # The L key
        KEY_M 'sfKeyM'            # The M key
        KEY_N 'sfKeyN'            # The N key
        KEY_O 'sfKeyO'            # The O key
        KEY_P 'sfKeyP'            # The P key
        KEY_Q 'sfKeyQ'            # The Q key
        KEY_R 'sfKeyR'            # The R key
        KEY_S 'sfKeyS'            # The S key
        KEY_T 'sfKeyT'            # The T key
        KEY_U 'sfKeyU'            # The U key
        KEY_V 'sfKeyV'            # The V key
        KEY_W 'sfKeyW'            # The W key
        KEY_X 'sfKeyX'            # The X key
        KEY_Y 'sfKeyY'            # The Y key
        KEY_Z 'sfKeyZ'            # The Z key
        KEY_NUM_0 'sfKeyNum0'         # The 0 key
        KEY_NUM_1 'sfKeyNum1'         # The 1 key
        KEY_NUM_2 'sfKeyNum2'         # The 2 key
        KEY_NUM_3 'sfKeyNum3'         # The 3 key
        KEY_NUM_4 'sfKeyNum4'         # The 4 key
        KEY_NUM_5 'sfKeyNum5'         # The 5 key
        KEY_NUM_6 'sfKeyNum6'         # The 6 key
        KEY_NUM_7 'sfKeyNum7'         # The 7 key
        KEY_NUM_8 'sfKeyNum8'         # The 8 key
        KEY_NUM_9 'sfKeyNum9'         # The 9 key
        KEY_ESCAPE 'sfKeyEscape'       # The Escape key
        KEY_L_CONTROL 'sfKeyLControl'     # The left Control key
        KEY_L_SHIFT 'sfKeyLShift'       # The left Shift key
        KEY_L_ALT 'sfKeyLAlt'         # The left Alt key
        KEY_L_SYSTEM 'sfKeyLSystem'      # The left OS specific key: window (Windows and Linux) apple (MacOS X) ...
        KEY_R_CONTROL 'sfKeyRControl'     # The right Control key
        KEY_R_SHIFT 'sfKeyRShift'       # The right Shift key
        KEY_R_ALT 'sfKeyRAlt'         # The right Alt key
        KEY_R_SYSTEM 'sfKeyRSystem'      # The right OS specific key: window (Windows and Linux) apple (MacOS X) ...
        KEY_MENU 'sfKeyMenu'         # The Menu key
        KEY_L_BRACKET 'sfKeyLBracket'     # The [ key
        KEY_R_BRACKET 'sfKeyRBracket'     # The ] key
        KEY_SEMI_COLON 'sfKeySemiColon'    # The ; key
        KEY_COMMA 'sfKeyComma'        # The  key
        KEY_PERIOD 'sfKeyPeriod'       # The . key
        KEY_QUOTE 'sfKeyQuote'        # The ' key
        KEY_SLASH 'sfKeySlash'        # The / key
        KEY_BACK_SLASH 'sfKeyBackSlash'    # The \ key
        KEY_TILDE 'sfKeyTilde'        # The ~ key
        KEY_EQUAL 'sfKeyEqual'        # The = key
        KEY_DASH 'sfKeyDash'         # The - key
        KEY_SPACE 'sfKeySpace'        # The Space key
        KEY_RETURN 'sfKeyReturn'       # The Return key
        KEY_BACK 'sfKeyBack'         # The Backspace key
        KEY_TAB 'sfKeyTab'          # The Tabulation key
        KEY_PAGE_UP 'sfKeyPageUp'       # The Page up key
        KEY_PAGE_DOWN 'sfKeyPageDown'     # The Page down key
        KEY_END 'sfKeyEnd'          # The End key
        KEY_HOME 'sfKeyHome'         # The Home key
        KEY_INSERT 'sfKeyInsert'       # The Insert key
        KEY_DELETE 'sfKeyDelete'       # The Delete key
        KEY_ADD 'sfKeyAdd'          # +
        KEY_SUBTRACT 'sfKeySubtract'     # -
        KEY_MULTIPLY 'sfKeyMultiply'     # *
        KEY_DIVIDE 'sfKeyDivide'       # /
        KEY_LEFT 'sfKeyLeft'         # Left arrow
        KEY_RIGHT 'sfKeyRight'        # Right arrow
        KEY_UP 'sfKeyUp'           # Up arrow
        KEY_DOWN 'sfKeyDown'         # Down arrow
        KEY_NUMPAD_0 'sfKeyNumpad0'      # The numpad 0 key
        KEY_NUMPAD_1 'sfKeyNumpad1'      # The numpad 1 key
        KEY_NUMPAD_2 'sfKeyNumpad2'      # The numpad 2 key
        KEY_NUMPAD_3 'sfKeyNumpad3'      # The numpad 3 key
        KEY_NUMPAD_4 'sfKeyNumpad4'      # The numpad 4 key
        KEY_NUMPAD_5 'sfKeyNumpad5'      # The numpad 5 key
        KEY_NUMPAD_6 'sfKeyNumpad6'      # The numpad 6 key
        KEY_NUMPAD_7 'sfKeyNumpad7'      # The numpad 7 key
        KEY_NUMPAD_8 'sfKeyNumpad8'      # The numpad 8 key
        KEY_NUMPAD_9 'sfKeyNumpad9'      # The numpad 9 key
        KEY_F1 'sfKeyF1'           # The F1 key
        KEY_F2 'sfKeyF2'           # The F2 key
        KEY_F3 'sfKeyF3'           # The F3 key
        KEY_F4 'sfKeyF4'           # The F4 key
        KEY_F5 'sfKeyF5'           # The F5 key
        KEY_F6 'sfKeyF6'           # The F6 key
        KEY_F7 'sfKeyF7'           # The F7 key
        KEY_F8 'sfKeyF8'           # The F8 key
        KEY_F9 'sfKeyF9'           # The F8 key
        KEY_F10 'sfKeyF10'          # The F10 key
        KEY_F11 'sfKeyF11'          # The F11 key
        KEY_F12 'sfKeyF12'          # The F12 key
        KEY_F13 'sfKeyF13'          # The F13 key
        KEY_F14 'sfKeyF14'          # The F14 key
        KEY_F15 'sfKeyF15'          # The F15 key
        KEY_PAUSE 'sfKeyPause'        # The Pause key
    
        KEY_COUNT 'sfKeyCount'      # Keep last -- the total number of keyboard keys
      
    cdef bint Keyboard_is_key_pressed 'sfKeyboard_isKeyPressed' (KeyCode key)


# SFML/Window/Mouse.h
################################################################################

cdef extern from 'SFML/Window/Mouse.h' nogil:
    ctypedef enum MouseButton 'sfMouseButton':
        MOUSE_BUTTON_LEFT 'sfMouseLeft' # The left mouse button
        MOUSE_BUTTON_RIGHT 'sfMouseRight' # The right mouse button
        MOUSE_BUTTON_MIDDLE 'sfMouseButtonMiddle' # The middle (wheel) mouse button
        MOUSE_BUTTON_X1 'sfMouseXButton1' # The first extra mouse button
        MOUSE_BUTTON_X2 'sfMouseXButton2' # The second extra mouse button
        MOUSE_BUTTON_COUNT 'sfMouseButtonCount' # Keep last - the total number of mouse buttons

    cdef bint Mouse_is_button_pressed 'sfMouse_isButtonPressed' (MouseButton button)
    cdef Vector2i Mouse_get_position 'sfMouse_getPosition' (const Window* relativeTo)
    cdef void Mouse_set_position 'sfMouse_setPosition' (Vector2i position, const Window* relativeTo)


# SFML/Window/Joystick.h
################################################################################

cdef extern from 'SFML/Window/Joystick.h' nogil:
    cdef enum:
        JOYSTICK_COUNT 'sfJoystickCount'
        JOYSTICK_BUTTON_COUNT 'sfJoystickButtonCount'
        JOYSTICK_AXIS_COUNT 'sfJoystickAxisCount'
    
    ctypedef enum JoystickAxis 'sfJoystickAxis':
        JOYSTICK_X 'sfJoystickX'
        JOYSTICK_Y 'sfJoystickY'
        JOYSTICK_Z 'sfJoystickZ'
        JOYSTICK_R 'sfJoystickR'
        JOYSTICK_U 'sfJoystickU'
        JOYSTICK_V 'sfJoystickV'
        JOYSTICK_POV_X 'sfJoystickPovX'
        JOYSTICK_POV_Y 'sfJoystickPovY'
    
    cdef bint Joystick_is_connected 'sfJoystick_isConnected' (unsigned int joystick)
    cdef unsigned int Joystick_get_button_count 'sfJoystick_getButtonCount' (unsigned int joystick)
    cdef bint Joystick_has_axis 'sfJoystick_hasAxis' (unsigned int joystick, JoystickAxis axis)
    cdef bint Joystick_is_button_pressed 'sfJoystick_isButtonPressed' (unsigned int joystick, unsigned int button)
    cdef float Joystick_get_axis_position 'sfJoystick_getAxisPosition' (unsigned int joystick, JoystickAxis axis)
    cdef void Joystick_update 'sfJoystick_update'()


# SFML/Window/Event.h
################################################################################

cdef extern from 'SFML/Window/Event.h' nogil:
    ctypedef enum EventType 'sfEventType':
        EVENT_CLOSED 'sfEvtClosed'
        EVENT_RESIZED 'sfEvtResized'
        EVENT_LOST_FOCUS 'sfEvtLostFocus'
        EVENT_GAINED_FOCUS 'sfEvtGainedFocus'
        EVENT_TEXT_ENTERED 'sfEvtTextEntered'
        EVENT_KEY_PRESSED 'sfEvtKeyPressed'
        EVENT_KEY_RELEASED 'sfEvtKeyReleased'
        EVENT_MOUSE_WHEEL_MOVED 'sfEvtMouseWheelMoved'
        EVENT_MOUSE_BUTTON_PRESSED 'sfEvtMouseButtonPressed'
        EVENT_MOUSE_BUTTON_RELEASED 'sfEvtMouseButtonReleased'
        EVENT_MOUSE_MOVED 'sfEvtMouseMoved'
        EVENT_MOUSE_ENTERED 'sfEvtMouseEntered'
        EVENT_MOUSE_LEFT 'sfEvtMouseLeft'
        EVENT_JOYSTICK_BUTTON_PRESSED 'sfEvtJoystickButtonPressed'
        EVENT_JOYSTICK_BUTTON_RELEASED 'sfEvtJoystickButtonReleased'
        EVENT_JOYSTICK_MOVED 'sfEvtJoystickMoved'
        EVENT_JOYSTICK_CONNECTED 'sfEvtJoystickConnected'
        EVENT_JOYSTICK_DISCONNECTED 'sfEvtJoystickDisconnected'

    ctypedef struct KeyEvent 'sfKeyEvent':
        EventType type
        KeyCode code
        bint alt
        bint control
        bint shift
        bint system
    
    ctypedef struct TextEvent 'sfTextEvent':
        EventType type
        Uint32 unicode
    
    ctypedef struct MouseMoveEvent 'sfMouseMoveEvent':
        EventType type
        int x
        int y
    
    ctypedef struct MouseButtonEvent 'sfMouseButtonEvent':
        EventType type
        unsigned int button
        int x
        int y
    
    ctypedef struct MouseWheelEvent 'sfMouseWheelEvent':
        EventType type
        int delta
        int x
        int y
    
    ctypedef struct JoystickMoveEvent 'sfJoystickMoveEvent':
        EventType type
        unsigned int joystick_id 'joystickId'
        JoystickAxis axis
        float position
    
    ctypedef struct JoystickButtonEvent 'sfJoystickButtonEvent':
        EventType type
        unsigned int joystick_id 'joystickId'
        unsigned int button
    
    ctypedef struct JoystickConnectEvent 'sfJoystickConnectEvent':
        EventType type
        unsigned int joystick_id 'joystickId'
    
    ctypedef struct SizeEvent 'sfSizeEvent':
        EventType type
        unsigned int width
        unsigned int height
    
    ctypedef struct Event 'sfEvent':
        EventType type
        # Q: CamelCase?
        SizeEvent size
        KeyEvent key
        TextEvent text
        MouseMoveEvent mouse_move 'mouseMove'
        MouseButtonEvent mouse_button 'mouseButton'
        MouseWheelEvent mouse_wheel 'mouseWheel'
        JoystickMoveEvent joystick_move 'joystickMove'
        JoystickButtonEvent joystick_button 'joystickButton'
        JoystickConnectEvent joystick_connect 'joystickConnect'


# SFML/Window/VideoMode.h
################################################################################

cdef extern from 'SFML/Window/VideoMode.h' nogil:
    ctypedef struct VideoMode 'sfVideoMode':
        unsigned int width
        unsigned int height
        unsigned int bits_per_pixel 'bitsPerPixel'
    
    cdef VideoMode VideoMode_get_desktop_mode 'sfVideoMode_getDesktopMode' ()

    cdef bint VideoMode_is_valid 'sfVideoMode_isValid' (VideoMode mode)
    
    cdef VideoMode* VideoMode_get_fullscreen_modes 'sfVideoMode_getFullscreenModes' (size_t* Count)


# SFML/Window/WindowHandle.h
################################################################################

cdef extern from 'SFML/Window/WindowHandle.h' nogil:
    ctypedef unsigned long WindowHandle 'sfWindowHandle'


# SFML/Window/Window.h
################################################################################

cdef extern from "SFML/Window/Window.h" nogil:
    # TODO: Support Windows.
    cdef enum:
        WINDOW_STYLE_NONE 'sfNone'
        WINDOW_STYLE_TITLEBAR 'sfTitlebar'
        WINDOW_STYLE_RESIZE 'sfResize'
        WINDOW_STYLE_CLOSE 'sfClose'
        WINDOW_STYLE_FULLSCREEN 'sfFullscreen'
        WINDOW_STYLE_DEFAULT 'sfDefaultStyle'
    
    ctypedef struct ContextSettings 'sfContextSettings':
        unsigned int depth_bits 'depthBits'
        unsigned int stencil_bits 'stencilBits'
        unsigned int antialiasing_level 'antialiasingLevel'
        unsigned int major_version 'majorVersion'
        unsigned int minor_version 'minorVersion'
    
    cdef Window* Window_create 'sfWindow_create' (VideoMode mode, const char* title, Uint32 style, const ContextSettings* settings)
    cdef void Window_close 'sfWindow_close' (Window* window)
    cdef void Window_destroy 'sfWindow_destroy' (Window* window)
    cdef bint Window_is_open 'sfWindow_isOpen' (const Window* window)
    cdef ContextSettings Window_get_settings 'sfWindow_getSettings' (const Window* window)
    cdef bint Window_poll_event 'sfWindow_pollEvent' (const Window* window, Event* event)
    cdef bint Window_wait_event 'sfWindow_waitEvent' (const Window* window, Event* event)
    cdef Vector2i Window_get_position 'sfWindow_getPosition' (const Window* window)
    cdef void Window_set_position 'sfWindow_setPosition' (Window* window, Vector2i position)
    
    cdef Vector2u Window_get_size 'sfWindow_getSize' (Window* window)
    cdef void Window_set_size 'sfWindow_setSize' (Window* window, Vector2u size)

    cdef void Window_set_title 'sfWindow_setTitle' (Window* window, const char* title)
    cdef void Window_set_unicode_title 'sfWindow_setUnicodeTitle' (Window* window, Uint32* title)
    cdef void Window_set_icon 'sfWindow_setIcon' (Window* window, unsigned int width, unsigned int height, const unsigned char* pixels)
    cdef void Window_set_visible 'sfWindow_setVisible' (Window* window, bint visible)
    cdef void Window_set_vertical_sync_enabled 'sfWindow_setVerticalSyncEnabled' (Window* window, bint enabled)
    cdef void Window_set_mouse_cursor_visible 'sfWindow_setMouseCursorVisible' (Window* window, bint visible)
    cdef void Window_set_key_repeat_enabled 'sfWindow_setKeyRepeatEnabled' (Window* window, bint enabled)
    cdef void Window_set_active 'sfWindow_setActive' (Window* window, bint active)
    cdef void Window_display 'sfWindow_display' (Window* window)
    cdef void Window_set_framerate_limit 'sfWindow_setFramerateLimit' (Window* window, unsigned int limit)
    cdef void Window_set_joystick_threshold 'sfWindow_setJoystickThreshold' (Window* window, float threshold)
    #cdef void WindowHandle Window_get_system_handle 'sfWindow_getSystemHandle' (Window *window)

