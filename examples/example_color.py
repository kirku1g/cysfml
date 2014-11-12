from random import randint

from examples.example import (
    Example,
    example_from_args,
)
from cysfml.system import (
    Vector2i,
    Vector2u,
)
from cysfml.graphics import (
    Color_add,
    Color_modulate,
    CircleShape,
    Color_from_rgb,
    Color_from_rgba,
    RenderWindow,
)
from cysfml.window import (
    VideoMode,
)


class ExampleColor(Example):
    
    def _run(self):
        self.example_color()
    
    def _setup_window(self):
        window = RenderWindow(320, 240, 32, b'Color')
        circle_shape = CircleShape()
        circle_shape.radius = 120
        circle_shape.position = 40, 0
        return window, circle_shape
    
    def _render(self, window, circle_shape):
        window.clear_rgb(0, 0, 0)
        circle_shape.draw(window)
        window.display()
    
    def example_color(self):
        window, circle_shape = self._setup_window()
        self.output('Colors can be created by calling either the graphics.Color_from_rgb(r, g, b)...')
        color = Color_from_rgb(255, 255, 255)
        for r in range(0, 255, 2):
            circle_shape.fill_color = r, 0, 0
            self._render(window, circle_shape)
        for g in range(0, 255, 2):
            circle_shape.fill_color = Color_from_rgb(0, g, 0)
            self._render(window, circle_shape)
        for b in range(0, 255, 2):
            circle_shape.fill_color = 0, 0, b, 255
            self._render(window, circle_shape)
        self.output('Or graphics.Color_from_rgba(r, g, b, a) for alpha-channel opacity...')
        for a in range(255, 0, -2):
            circle_shape.fill_color = Color_from_rgba(
                randint(128, 255),
                randint(128, 255),
                randint(128, 255),
                a,
            )
        self.output('Colors can be added, i.e. component-wise saturated addition, by calling graphics.Color_add(color1, color2)...')
        red = Color_from_rgb(255, 0, 0)
        blue_addition = Color_from_rgb(0, 0, 2)
        for x in range(0, 255, 2):
            red = Color_add(red, blue_addition)
            circle_shape.fill_color = red
            self._render(window, circle_shape)


if __name__ == '__main__':
    example_from_args({
        'python': ExampleColor,
    }).run()

