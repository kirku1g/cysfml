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
    JOYSTICK_COUNT,
    KEY_NAMES,
    MOUSE_BUTTON_NAMES,
    is_joystick_connected,
    is_key_pressed,
    is_key_code_pressed,
    is_mouse_button_code_pressed,
    is_mouse_button_pressed,
)


class ExampleInputDevices(Example):
    
    def _run(self):
        self.example_keyboard_input()
        self.example_mouse_input()
        self.example_joystick_input()
    
    def example_keyboard_input(self):
        self.output('The state of input devices can be queried without handling window events.')
        self.output('Check if a key is pressed by calling window.is_key_code_pressed()...')
        self.output('The following key codes are pressed: %s' % [x for x in range(len(KEY_NAMES)) if is_key_code_pressed(x)])
        self.output('Keys can be queried by name by calling window.is_key_pressed()...')
        self.output('The following key names are pressed: %s' % [k for k in KEY_NAMES if is_key_pressed(k)])
    
    def example_mouse_input(self):
        self.output('Check if a mouse button is pressed by calling window.is_mouse_button_code_pressed()...')
        self.output('The following mouse button codes are pressed: %s' % ', '.join(str(x) for x in range(len(MOUSE_BUTTON_NAMES)) if is_mouse_button_code_pressed(x)))
        self.output('Mouse buttons can be queried by name by calling window.is_mouse_button_pressed()...')
        self.output('The following mouse button names are pressed: %s' % b', '.join(m for m in MOUSE_BUTTON_NAMES if is_mouse_button_pressed(m)))
    
    def example_joystick_input(self):
        self.output('Check if a joystick is connected by calling window.is_joystick_connected()...')
        for x in range(JOYSTICK_COUNT):
            connected = is_joystick_connected(x)
            self.output('window.is_joystick_created(%d) == %s' % (x, connected))
            if connected:
                self.output('The window.Joystick class can be instantiated with a joystick number argument...')
                joystick = Joystick(x)
                # TODO
                button_count = joystick.get_button_count()
                for button in range(button_count):
                    joystick.is_button_pressed(button)
                for axis in range(JOYSTICK_AXIS_COUNT):
                    joystick.axis_position(axis)


if __name__ == '__main__':
    example_from_args({
        'python': ExampleInputDevices,
    }).run()
