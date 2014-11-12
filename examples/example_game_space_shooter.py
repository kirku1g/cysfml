import random
from cygame import director, resources

# It is recommended to initialise these as early as possible.
resource_manager = resources.init(b'data')
director = director.init(width=640, height=480)


class Laser(Layer):
    
    def __init__(self, x, remove):
        self.position = x, 50
        director.schedule(self.move_up)
        self.remove = remove
    
    def update(self, elapsed):
        self.y -= 100 * elapsed
        if self.y < -10:
            self.remove()


class Rock(Layer):
    
    def __init__(self, x, remove):
        self.position_xy = random.randint(0, director.width), -10
        director.schedule(self.move_down)
        self.remove = remove
    
    def update(self, elapsed):
        self.y += 40
        if self.y > director.width + 10:
            self.remove()
    


class GameOverScene(Scene):
    def __init__(self):
        self.key_handlers = {
            'SPACE': lambda *args: director.switch_scene(MainScene),
            'ESCAPE': lambda *args: director.quit,
        }
        self.add(align(Label(b'Game Over!', 32), 0, director.width, ALIGN_CENTER, ALIGN_CENTER))


class MainScene(Scene):
    
    def __init__(self):
        self.key_handlers = {
            'LEFT': self.move_left,
            'UP': self.move_right,
            'SPACE': self.fire,
            'ESCAPE': lambda *args: director.quit,
        }
        
        self.player_speed = 20
        self.game_over = False
        self.schedule_interval(self.add_rock, 2)
        self.rock_laser_collision_detector = CollisionDetector((b'rock', b'laser'), self.rock_laser_collision)
        self.rock_player_collision_detector = CollisionDetector((b'rock', b'player'), self.rock_player_collision)
    
    def key_event(self, code, alt, control, shift, system):
        pass
    
    def move_left(self, elapsed, alt, control, shift, system):
        self.player.move_xy(max(-(elapsed * self.player_speed), 0), 0)
    
    def move_right(self, elapsed, alt, control, shift, system):
        self.player.move_xy(min(elapsed * self.player_speed, self.director), 0)
    
    def fire(self, elapsed, alt, control, shift, system):
        self.add(Laser(self.player.x, self.remove))
        self.rock_laser_collision_detector.add(b'laser', laser)
    
    def quit(self, elapsed, alt, control, shift, system):
        self.director.quit()
    
    def add_rock(self, elapsed):
        self.add(Rock(self.player.x, self.remove))
        self.rock_laser_collision_detector.add(b'rock', rock)
        self.rock_player_collision_detector.add(b'rock', rock)
    
    def rock_laser_collision(self, rock, laser):
        rock.explode()
        self.remove(laser)
    
    def rock_player_collision(self, rock, player):
        # TODO: Explode player
        director.switch_scene(GameOverScene)


class GameOverScene(Scene):
    def __init__(self):
        self.key_handlers = {
            'SPACE': self.restart,
            'ESCAPE': lambda *args: director.quit,
        }
        self.add(align(Label(b'Game Over!', 32), 0, director.width, ALIGN_CENTER, ALIGN_CENTER))
    
    def restart(self, elapsed, alt, control, shift, system):
        director.switch_scene(MainScene)
        


def main():
    director.run()
    