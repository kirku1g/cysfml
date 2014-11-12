import unittest

from cysfml import graphics, system


class TestFloatRect(unittest.TestCase):
    
    def test_FloatRect(self):
        left = 1.5
        top = 2.25
        width = 3.75
        height = 4.9
        rect = graphics.FloatRect(
            left,
            top,
            width,
            height,
        )
        self.assertEqual(len(rect), 4)
        self.assertAlmostEqual(rect['left'], left, places=2)
        self.assertAlmostEqual(rect['top'], top, places=2)
        self.assertAlmostEqual(rect['width'], width, places=2)
        self.assertAlmostEqual(rect['height'], height, places=2)
    
    def test_FloatRect_unpack(self):
        left = -1.5
        top = -2.25
        width = -3.75
        height = -4.9
        rect = graphics.FloatRect(
            left,
            top,
            width,
            height,
        )
        rect_left, rect_top, rect_width, rect_height = graphics.FloatRect_unpack(rect)
        self.assertAlmostEqual(rect_left, left, places=2)
        self.assertAlmostEqual(rect_top, top, places=2)
        self.assertAlmostEqual(rect_width, width, places=2)
        self.assertAlmostEqual(rect_height, height, places=2)
    
    def test_FloatRect_cast(self):
        left = 10.5
        top = -20.25
        width = 30.75
        height = -40.9
        rect = graphics.FloatRect(
            left,
            top,
            width,
            height,
        )
        rect_cast = graphics.FloatRect_cast(rect)
        rect_left, rect_top, rect_width, rect_height = graphics.FloatRect_unpack(rect)
        self.assertAlmostEqual(rect_left, left, places=2)
        self.assertAlmostEqual(rect_top, top, places=2)
        self.assertAlmostEqual(rect_width, width, places=2)
        self.assertAlmostEqual(rect_height, height, places=2)
        rect_ltwh = graphics.FloatRect_cast((
            left,
            top,
            width,
            height,
        ))
        rect_left, rect_top, rect_width, rect_height = graphics.FloatRect_unpack(rect_ltwh)
        self.assertAlmostEqual(rect_left, left, places=2)
        self.assertAlmostEqual(rect_top, top, places=2)
        self.assertAlmostEqual(rect_width, width, places=2)
        self.assertAlmostEqual(rect_height, height, places=2)
    
    def test_FloatRect_contains(self):
        left = -10
        top = -2.5
        width = 20
        height = 5
        rect = graphics.FloatRect(left, top, width, height)
        rect_ltwh = (left, top, width, height)
        self.assertTrue(graphics.FloatRect_contains(rect, 0, 0))
        self.assertTrue(graphics.FloatRect_contains(rect_ltwh, 0, 0))
        
        self.assertTrue(graphics.FloatRect_contains(rect, -10, -2.5))
        self.assertTrue(graphics.FloatRect_contains(rect, -10, 0))
        self.assertTrue(graphics.FloatRect_contains(rect, 0, -2.5))
        
        self.assertTrue(graphics.FloatRect_contains(rect, -10, -2.5))
        self.assertTrue(graphics.FloatRect_contains(rect, -10, 0))
        self.assertTrue(graphics.FloatRect_contains(rect, 0, -2.5))
        
        self.assertFalse(graphics.FloatRect_contains(rect, 10, 2.5))
        self.assertFalse(graphics.FloatRect_contains(rect, 10, 0))
        self.assertFalse(graphics.FloatRect_contains(rect, 0, 2.5))
        
        self.assertFalse(graphics.FloatRect_contains(rect, -100, -50.125))
        self.assertFalse(graphics.FloatRect_contains(rect, 125.25, 100))
        
        self.assertTrue(graphics.FloatRect_contains_rect(rect, 0, 0))
        self.assertFalse(graphics.FloatRect_contains_rect(rect, -100, -50.125))
        
        self.assertTrue(graphics.FloatRect_contains_ltwh(left, top, width, height, 0, 0))
        self.assertFalse(graphics.FloatRect_contains_ltwh(left, top, width, height, -100, -50.125))
    
    def test_FloatRect_intersects(self):
        left1 = -10
        top1 = -2.5
        width1 = 20
        height1 = 5
        
        left2 = 0
        top2 = 0
        width2 = 5
        height2 = 5
        
        left3 = 20
        top3 = -100
        width3 = 5
        height3 = 5
        
        rect1 = graphics.FloatRect(left1, top1, width1, height1)
        rect1_ltwh = (left1, top1, width1, height1)
        rect2 = graphics.FloatRect(left2, top2, width2, height2)
        rect2_ltwh = (left2, top2, width2, height2)
        rect3 = graphics.FloatRect(left3, top3, width3, height3)
        rect3_ltwh = (left3, top3, width3, height3)
        
        empty_intersection_ltwh = (0, 0, 0, 0)
        empty_intersection = graphics.FloatRect_cast(empty_intersection_ltwh)
        rect12_intersection_ltwh = (0, 0, 5, 2.5)
        rect12_intersection = graphics.FloatRect_cast(rect12_intersection_ltwh)
        
        self.assertEqual(graphics.FloatRect_intersects(rect1, rect2),
                         (True, rect12_intersection_ltwh))
        self.assertEqual(graphics.FloatRect_intersects(rect1_ltwh, rect2_ltwh),
                         (True, rect12_intersection_ltwh))
        self.assertEqual(graphics.FloatRect_intersects(rect2, rect1),
                         (True, rect12_intersection_ltwh))
        self.assertEqual(graphics.FloatRect_intersects(rect2_ltwh, rect1_ltwh),
                         (True, rect12_intersection_ltwh))
        
        self.assertEqual(graphics.FloatRect_intersects(rect1, rect3),
                         (False, empty_intersection_ltwh))
        self.assertEqual(graphics.FloatRect_intersects(rect1, rect3),
                         (False, empty_intersection_ltwh))
        self.assertEqual(graphics.FloatRect_intersects(rect2, rect3),
                        (False, empty_intersection_ltwh))
        self.assertEqual(graphics.FloatRect_intersects(rect2, rect3),
                         (False, empty_intersection_ltwh))


class TestIntRect(unittest.TestCase):
    
    def test_IntRect(self):
        left = 2
        top = 3
        width = 4
        height = 6
        rect = graphics.IntRect(
            left,
            top,
            width,
            height,
        )
        self.assertEqual(len(rect), 4)
        self.assertAlmostEqual(rect['left'], left, places=2)
        self.assertAlmostEqual(rect['top'], top, places=2)
        self.assertAlmostEqual(rect['width'], width, places=2)
        self.assertAlmostEqual(rect['height'], height, places=2)
    
    def test_IntRect_unpack(self):
        left = -2
        top = -3
        width = 4
        height = 8
        rect = graphics.IntRect(
            left,
            top,
            width,
            height,
        )
        rect_left, rect_top, rect_width, rect_height = graphics.IntRect_unpack(rect)
        self.assertAlmostEqual(rect_left, left, places=2)
        self.assertAlmostEqual(rect_top, top, places=2)
        self.assertAlmostEqual(rect_width, width, places=2)
        self.assertAlmostEqual(rect_height, height, places=2)
    
    def test_IntRect_cast(self):
        left = -20
        top = 20
        width = 30
        height = 40
        rect = graphics.IntRect(
            left,
            top,
            width,
            height,
        )
        rect_cast = graphics.IntRect_cast(rect)
        rect_left, rect_top, rect_width, rect_height = graphics.IntRect_unpack(rect)
        self.assertAlmostEqual(rect_left, left, places=2)
        self.assertAlmostEqual(rect_top, top, places=2)
        self.assertAlmostEqual(rect_width, width, places=2)
        self.assertAlmostEqual(rect_height, height, places=2)
        rect_ltwh = graphics.IntRect_cast((
            left,
            top,
            width,
            height,
        ))
        rect_left, rect_top, rect_width, rect_height = graphics.IntRect_unpack(rect_ltwh)
        self.assertAlmostEqual(rect_left, left, places=2)
        self.assertAlmostEqual(rect_top, top, places=2)
        self.assertAlmostEqual(rect_width, width, places=2)
        self.assertAlmostEqual(rect_height, height, places=2)
    
    def test_IntRect_contains(self):
        left = -10
        top = -3
        width = 20
        height = 6
        rect = graphics.IntRect(left, top, width, height)
        rect_ltwh = (left, top, width, height)
        self.assertTrue(graphics.IntRect_contains(rect, 0, 0))
        self.assertTrue(graphics.IntRect_contains(rect_ltwh, 0, 0))
        
        self.assertTrue(graphics.IntRect_contains(rect, -10, -3))
        self.assertTrue(graphics.IntRect_contains(rect, -10, 0))
        self.assertTrue(graphics.IntRect_contains(rect, 0, -3))
        
        self.assertTrue(graphics.IntRect_contains(rect, -10, -3))
        self.assertTrue(graphics.IntRect_contains(rect, -10, 0))
        self.assertTrue(graphics.IntRect_contains(rect, 0, -3))
        
        self.assertFalse(graphics.IntRect_contains(rect, 10, 3))
        self.assertFalse(graphics.IntRect_contains(rect, 10, 0))
        self.assertFalse(graphics.IntRect_contains(rect, 0, 3))
        
        self.assertFalse(graphics.IntRect_contains(rect, -100, -50))
        self.assertFalse(graphics.IntRect_contains(rect, 125, 100))
        
        self.assertTrue(graphics.IntRect_contains_rect(rect, 0, 0))
        self.assertFalse(graphics.IntRect_contains_rect(rect, -100, -50))
        
        self.assertTrue(graphics.IntRect_contains_ltwh(left, top, width, height, 0, 0))
        self.assertFalse(graphics.IntRect_contains_ltwh(left, top, width, height, -100, -50))
    
    def test_IntRect_intersects(self):
        left1 = -10
        top1 = -3
        width1 = 20
        height1 = 6
        
        left2 = 0
        top2 = 0
        width2 = 6
        height2 = 6
        
        left3 = 20
        top3 = -100
        width3 = 5
        height3 = 5
        
        rect1 = graphics.IntRect(left1, top1, width1, height1)
        rect1_ltwh = (left1, top1, width1, height1)
        rect2 = graphics.IntRect(left2, top2, width2, height2)
        rect2_ltwh = (left2, top2, width2, height2)
        rect3 = graphics.IntRect(left3, top3, width3, height3)
        rect3_ltwh = (left3, top3, width3, height3)
        
        empty_intersection_ltwh = (0, 0, 0, 0)
        empty_intersection = graphics.IntRect_cast(empty_intersection_ltwh)
        rect12_intersection_ltwh = (0, 0, 6, 3)
        rect12_intersection = graphics.IntRect_cast(rect12_intersection_ltwh)
        
        self.assertEqual(graphics.IntRect_intersects(rect1, rect2),
                         (True, rect12_intersection_ltwh))
        self.assertEqual(graphics.IntRect_intersects(rect1_ltwh, rect2_ltwh),
                         (True, rect12_intersection_ltwh))
        self.assertEqual(graphics.IntRect_intersects(rect2, rect1),
                         (True, rect12_intersection_ltwh))
        self.assertEqual(graphics.IntRect_intersects(rect2_ltwh, rect1_ltwh),
                         (True, rect12_intersection_ltwh))
        
        self.assertEqual(graphics.IntRect_intersects(rect1, rect3),
                         (False, empty_intersection_ltwh))
        self.assertEqual(graphics.IntRect_intersects(rect1, rect3),
                         (False, empty_intersection_ltwh))
        self.assertEqual(graphics.IntRect_intersects(rect2, rect3),
                        (False, empty_intersection_ltwh))
        self.assertEqual(graphics.IntRect_intersects(rect2, rect3),
                         (False, empty_intersection_ltwh))


class TestColor(unittest.TestCase):
    def test_Color_from_rgb(self):
        r = 255
        g = 0
        b = 128
        self.assertEqual(graphics.Color_from_rgb(r, g, b),
                         {'r': r, 'g': g, 'b': b, 'a': 255})
    
    def test_Color_unpack_rgb(self):
        r = 255
        g = 0
        b = 128
        color = graphics.Color_from_rgb(r, g, b)
        self.assertEqual(graphics.Color_unpack_rgb(color), (r, g, b))
    
    def test_Color_cast(self):
        r = 255
        g = 0
        b = 128
        a = 64
        
    
    def test_Color_from_rgb(self):
        r = 255
        g = 0
        b = 128
        a = 64
        self.assertEqual(graphics.Color_from_rgba(r, g, b, a),
                         {'r': r, 'g': g, 'b': b, 'a': a})
    
    def test_Color_unpack_rgb(self):
        r = 255
        g = 0
        b = 128
        a = 64
        color = graphics.Color_from_rgba(r, g, b, a)
        self.assertEqual(graphics.Color_unpack_rgba(color), (r, g, b, a))
    
    def test_Color_add(self):
        r1 = 255
        g1 = 0
        b1 = 128
        a1 = 64
        color1 = graphics.Color_from_rgba(r1, g1, b1, a1)
        rgb1 = (r1, g1, b1)
        rgba1 = (r1, g1, b1, a1)

        r2 = 255
        g2 = 32
        b2 = 64
        a2 = 128
        color2 = graphics.Color_from_rgba(r2, g2, b2, a2)
        rgb2 = (r2, g2, b2)
        rgba2 = (r2, g2, b2, a2)
        
        rx = 255
        gx = 32
        bx = 192
        ax = 192
        colorx = graphics.Color_from_rgba(rx, gx, bx, ax)
        rgbx = (rx, gx, bx, 255)
        rgbax = (rx, gx, bx, ax)
        
        self.assertEqual(
            graphics.Color_add(color1, color2),
            rgbax,
        )
        self.assertEqual(
            graphics.Color_add(rgb1, rgb2),
            rgbx,
        )
        self.assertEqual(
            graphics.Color_add(rgba1, rgba2),
            rgbax,
        )
        self.assertEqual(
            graphics.Color_add_rgb(*rgb1 + rgb2),
            rgbx[:3],
        )
        self.assertEqual(
            graphics.Color_add_rgba(*rgba1 + rgba2),
            rgbax,
        )
        
    def test_Color_modulate(self):
        r1 = 255
        g1 = 0
        b1 = 128
        a1 = 64
        color1 = graphics.Color_from_rgba(r1, g1, b1, a1)
        rgb1 = (r1, g1, b1)
        rgba1 = (r1, g1, b1, a1)

        r2 = 255
        g2 = 32
        b2 = 64
        a2 = 128
        color2 = graphics.Color_from_rgba(r2, g2, b2, a2)
        rgb2 = (r2, g2, b2)
        rgba2 = (r2, g2, b2, a2)
        
        rx = 255
        gx = 0
        bx = 32
        ax = 32
        colorx = graphics.Color_from_rgba(rx, gx, bx, ax)
        rgbx = (rx, gx, bx, 255)
        rgbax = (rx, gx, bx, ax)
        
        self.assertEqual(
            graphics.Color_modulate(color1, color2),
            rgbax,
        )
        self.assertEqual(
            graphics.Color_modulate(rgb1, rgb2),
            rgbx,
        )
        self.assertEqual(
            graphics.Color_modulate(rgba1, rgba2),
            rgbax,
        )
        self.assertEqual(
            graphics.Color_modulate_rgb(*rgb1 + rgb2),
            rgbx[:3],
        )
        self.assertEqual(
            graphics.Color_modulate_rgba(*rgba1 + rgba2),
            rgbax,
        )


class TestVertex(unittest.TestCase):
    def test_Vertex(self):
        pos_x = 10
        pos_y = 20
        r = 30
        g = 40
        b = 50
        a = 60
        tex_x = 70
        tex_y = 80
        expected = {
            'position': {
                'x': pos_x, 
                'y': pos_y
            },
            'color': {
                'r': r,
                'g': g,
                'b': b,
                'a': a,
            },
            'tex_coords': {
                'x': tex_x,
                'y': tex_y,
            },
        }
        self.assertEqual(
            graphics.Vertex(
                system.Vector2f(pos_x, pos_y),
                graphics.Color_from_rgba(r, g, b, a),
                system.Vector2f(tex_x, tex_y),
            ),
            expected,
        )
        self.assertEqual(
            graphics.Vertex(
                (pos_x, pos_y),
                (r, g, b, a),
                (tex_x, tex_y),
            ),
            expected,
        )
        self.assertEqual(
            graphics.Vertex_struct(
                system.Vector2f(pos_x, pos_y),
                graphics.Color_from_rgba(r, g, b, a),
                system.Vector2f(tex_x, tex_y),
            ),
            expected,
        )
        self.assertEqual(
            graphics.Vertex_args(
                pos_x, pos_y,
                r, g, b, a,
                tex_x, tex_y,
            ),
            expected,
        )


class TestTransform(unittest.TestCase):
    def test_Transform(self):
        t = graphics.Transform()
        # TODO: Test
    
    def test_from_matrix(self):
        t = graphics.Transform.from_matrix(1, 2, 3, 4, 5, 6, 7, 8, 9)
        # TODO: Test
    
    def test_get_inverse(self):
        t = graphics.Transform()
        inverse = t.get_inverse()
        inverse_prop = t.inverse
        # TODO: Test
    
    def test_get_matrix(self):
        t = graphics.Transform()
        self.assertEqual(t.get_matrix(), (1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1))
        self.assertEqual(t.get_matrix(), t.matrix)
    
    def test_transform_rect(self):
        left = 10
        top = 20
        width = 30
        height = 40
        rect_args = (left, top, width, height)
        rect = graphics.FloatRect(*rect_args)
        t = graphics.Transform()
        self.assertEqual(len(t.transform_rect(rect_args)), 4)
        self.assertEqual(len(t.transform_rect(rect)), 4)
        self.assertTrue(isinstance(t.transform_rect_struct(graphics.FloatRect(left, top, width, height)), dict))
        self.assertEqual(len(t.transform_rect_ltwh(*rect_args)), 4)
    
    def test_combine(self):
        t1 = graphics.Transform.from_matrix(1, 2, 3, 4, 5, 6, 7, 8, 9)
        t2 = graphics.Transform.from_matrix(10, 2, 3, 4, 5, 6, 7, 8, 9)
        # TODO: Fix crashing.
        #t2.combine(t1)
        #t1.combine(t2)
        #self.assertEqual(t1.matrix, t2.matrix)
        
        # TODO: Test
    
    def test_translate(self):
        t = graphics.Transform()
        t.translate(1, 2)
        # TODO: Test
    
    def test_rotate(self):
        t = graphics.Transform()
        t.rotate(5)
    
    def test_rotate_with_center(self):
        t = graphics.Transform()
        t.rotate_with_center(2, 3, 4)
    
    def test_scale(self):
        t = graphics.Transform()
        t.scale(1, 2)
    
    def test_scale_with_center(self):
        t = graphics.Transform()
        t.scale_with_center(5, 6, 7, 8)


class TestTexture(unittest.TestCase):
    def test_maximum_size(self):
        # TODO: Fix evaluation causing segfault.
        graphics.Texture.get_maximum_size()
    
    def test_Texture(self):
        t = graphics.Texture(320, 240)
    
    def test_get_size(self):
        size = (320, 240)
        t = graphics.Texture(*size)
        self.assertEqual(t.get_size(), size)
        self.assertEqual(t.get_size_xy(), size)
        self.assertEqual(t.size, size)
        self.assertEqual(t.get_size_struct(), system.Vector2u_cast(size))
    
    def test_bind(self):
        t = graphics.Texture(320, 240)
        t.bind()
    
    def test_destroy(self):
        t = graphics.Texture(320, 240)
        t.destroy()


if __name__ == '__main__':
    unittest.main()

