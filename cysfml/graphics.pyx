from config cimport (
    Uint8,
    Uint32,
)

cimport csystem
cimport system

cimport cwindow
cimport window

cimport cgraphics

cimport utils


# PrimitiveType
#################################################################################

POINTS = cgraphics.POINTS
LINES = cgraphics.LINES
LINES_STRIP = cgraphics.LINES_STRIP
TRIANGLES = cgraphics.TRIANGLES
TRIANGLES_STRIP = cgraphics.TRIANGLES_STRIP
TRIANGLES_FAM = cgraphics.TRIANGLES_FAM
QUADS = cgraphics.QUADS


# BlendMode
#################################################################################

BLEND_ALPHA = cgraphics.BLEND_ALPHA
BLEND_ADD = cgraphics.BLEND_ADD
BLEND_MULTIPLY = cgraphics.BLEND_MULTIPLY
BLEND_NONE = cgraphics.BLEND_NONE


# Rect
#################################################################################


# FloatRect

cpdef cgraphics.FloatRect FloatRect(float left, float top, float width, float height):
    '''
    Create a cgraphics.FloatRect struct from left, top, width and height float values.
    '''
    cdef cgraphics.FloatRect rect
    rect.left = left
    rect.top = top
    rect.width = width
    rect.height = height
    return rect


cpdef tuple FloatRect_unpack(cgraphics.FloatRect rect):
    '''
    Unpack a cgraphics.FloatRect struct into a tuple containing left, top, width and height.
    '''
    return rect.left, rect.top, rect.width, rect.height


cpdef cgraphics.FloatRect FloatRect_cast(value):
    '''
    Casts the following into a cgraphics.FloatRect struct:
     - tuple containing left, top, width, height.
     - list containing left, top, width, height.
     - dict containing left, top, width and height keys.
     - cgraphics.FloatRect struct (unchanged).
    '''
    return FloatRect(*value) if utils.is_iterable(value) else value


# FloatRect_contais

cpdef bint FloatRect_contains(rect, float x, float y):
    '''
    Check if a point is inside a rectangle's area.
    
    :param: Rectangle object passed into FloatRect_cast.
    '''
    cdef cgraphics.FloatRect rect_struct = FloatRect_cast(rect)
    return cgraphics.FloatRect_contains(&rect_struct, x, y)


cpdef bint FloatRect_contains_struct(cgraphics.FloatRect rect, float x, float y):
    '''
    Check if a point is inside a rectangle's area.
    
    :param rect: FloatRect struct
    '''
    return cgraphics.FloatRect_contains(&rect, x, y)


cdef bint FloatRect_contains_struct_ptr(cgraphics.FloatRect* rect, float x, float y):
    '''
    Check if a point is inside a rectangle's area.
    
    :param rect: FloatRect struct pointer
    '''
    return cgraphics.FloatRect_contains(rect, x, y)


cpdef bint FloatRect_contains_ltwh(
        float left,
        float top,
        float width,
        float height,
        float x,
        float y):
    '''
    Check if a point is inside a rectangle's area.
    '''
    cdef cgraphics.FloatRect rect_struct = FloatRect(left, top, width, height)
    return cgraphics.FloatRect_contains(&rect_struct, x, y)


# FloatRect_intersects

cpdef tuple FloatRect_intersects(rect1, rect2):
    '''
    Check intersection between two rectangles using FloatRect_cast.
    
    See also:
    
     - FloatRect_intersects_rect
     - FloatRect_intersects_rect_ptr
     - FloatRect_intersects_ltwh
    
    :returns: A tuple containing whether or not the rects intersect and the intersection rect.
    '''
    cdef cgraphics.FloatRect rect1_struct, rect2_struct, intersection_struct
    rect1_struct = FloatRect_cast(rect1)
    rect2_struct = FloatRect_cast(rect2)
    cdef bint intersects = cgraphics.FloatRect_intersects(
        &rect1_struct,
        &rect2_struct,
        &intersection_struct,
    )
    return (intersects, FloatRect_unpack(intersection_struct))


cdef bint FloatRect_intersects_struct_ptr(
        cgraphics.FloatRect* rect1,
        cgraphics.FloatRect* rect2,
        cgraphics.FloatRect* intersection):
    '''
    Check intersection between two rectangle struct pointers.
    
    See also:
    
     - FloatRect_intersects
     - FloatRect_intersects_rect
     - FloatRect_intersects_ltwh
    
    :param intersection: Out param containing intersection.
    :returns: Whether or not the rects intersect.
    '''
    return cgraphics.FloatRect_intersects(
        rect1,
        rect2,
        intersection,
    )


cpdef tuple FloatRect_intersects_ltwh(
        float left1,
        float top1,
        float width1,
        float height1,
        float left2,
        float top2,
        float width2,
        float height2):
    '''
    Check intersection between two rectangles defined as left, top, width, height.
    
    See also:
    
     - FloatRect_intersects
     - FloatRect_intersects_rect
     - FloatRect_intersects_ltwh
    
    :returns: A tuple containing whether or not the rects intersect and the intersection rect.
    '''
    
    cdef cgraphics.FloatRect rect1, rect2, intersection
    rect1 = FloatRect(left1, top1, width1, height1)
    rect2 = FloatRect(left2, top2, width2, height2)
    cdef bint intersects = cgraphics.FloatRect_intersects(
        &rect1,
        &rect2,
        &intersection,
    )
    return (intersects, FloatRect_unpack(intersection))


# IntRect

cpdef cgraphics.IntRect IntRect(int left, int top, int width, int height):
    '''
    Create a cgraphics.IntRect struct from left, top, width and height int values.
    '''
    cdef cgraphics.IntRect rect
    rect.left = left
    rect.top = top
    rect.width = width
    rect.height = height
    return rect


cpdef tuple IntRect_unpack(cgraphics.IntRect rect):
    '''
    Unpack a cgraphics.IntRect struct into a tuple containing left, top, width and height.
    '''
    return rect.left, rect.top, rect.width, rect.height


cpdef cgraphics.IntRect IntRect_cast(value):
    '''
    Casts the following into a cgraphics.IntRect struct:
     - tuple containing left, top, width, height.
     - list containing left, top, width, height.
     - dict containing left, top, width and height keys.
     - cgraphics.IntRect struct (unchanged).
    '''
    return IntRect(*value) if utils.is_iterable(value) else value


# IntRect_contais

cpdef bint IntRect_contains(rect, int x, int y):
    '''
    Check if a point is inside a rectangle's area.
    
    :param: Rectangle object passed into IntRect_cast.
    '''
    cdef cgraphics.IntRect rect_struct = IntRect_cast(rect)
    return cgraphics.IntRect_contains(&rect_struct, x, y)


cpdef bint IntRect_contains_struct(cgraphics.IntRect rect, int x, int y):
    '''
    Check if a point is inside a rectangle's area.
    
    :param rect: IntRect struct
    '''
    return cgraphics.IntRect_contains(&rect, x, y)


cdef bint IntRect_contains_struct_ptr(cgraphics.IntRect* rect, int x, int y):
    '''
    Check if a point is inside a rectangle's area.
    
    :param rect: IntRect struct pointer
    '''
    return cgraphics.IntRect_contains(rect, x, y)


cpdef bint IntRect_contains_ltwh(
        int left,
        int top,
        int width,
        int height,
        int x,
        int y):
    '''
    Check if a point is inside a rectangle's area.
    '''
    cdef cgraphics.IntRect rect_struct = IntRect(left, top, width, height)
    return cgraphics.IntRect_contains(&rect_struct, x, y)


# IntRect_intersects

cpdef tuple IntRect_intersects(rect1, rect2):
    '''
    Check intersection between two rectangles using IntRect_cast.
    
    See also:
    
     - IntRect_intersects_rect
     - IntRect_intersects_rect_ptr
     - IntRect_intersects_ltwh
    
    :returns: A tuple containing whether or not the rects intersect and the intersection rect.
    '''
    cdef cgraphics.IntRect rect1_struct, rect2_struct, intersection_struct
    rect1_struct = IntRect_cast(rect1)
    rect2_struct = IntRect_cast(rect2)
    cdef bint intersects = cgraphics.IntRect_intersects(
        &rect1_struct,
        &rect2_struct,
        &intersection_struct,
    )
    return (intersects, IntRect_unpack(intersection_struct))


cdef bint IntRect_intersects_struct_ptr(
        cgraphics.IntRect* rect1,
        cgraphics.IntRect* rect2,
        cgraphics.IntRect* intersection):
    '''
    Check intersection between two rectangle struct pointers.
    
    See also:
    
     - IntRect_intersects
     - IntRect_intersects_rect
     - IntRect_intersects_ltwh
    
    :param intersection: Out param containing intersection.
    :returns: Whether or not the rects intersect.
    '''
    return cgraphics.IntRect_intersects(
        rect1,
        rect2,
        intersection,
    )


cpdef tuple IntRect_intersects_ltwh(
        int left1,
        int top1,
        int width1,
        int height1,
        int left2,
        int top2,
        int width2,
        int height2):
    '''
    Check intersection between two rectangles defined as left, top, width, height.
    
    See also:
    
     - IntRect_intersects
     - IntRect_intersects_rect
     - IntRect_intersects_ltwh
    
    :returns: A tuple containing whether or not the rects intersect and the intersection rect.
    '''
    
    cdef cgraphics.IntRect rect1, rect2, intersection
    rect1 = IntRect(left1, top1, width1, height1)
    rect2 = IntRect(left2, top2, width2, height2)
    cdef bint intersects = cgraphics.IntRect_intersects(
        &rect1,
        &rect2,
        &intersection,
    )
    return (intersects, IntRect_unpack(intersection))


# Color
#################################################################################

cpdef cgraphics.Color Color_from_rgb(Uint8 r, Uint8 g, Uint8 b):
    return cgraphics.Color_from_rgb(r, g, b)


cpdef cgraphics.Color Color_from_rgba(Uint8 r, Uint8 g, Uint8 b, Uint8 a):
    return cgraphics.Color_from_rgba(r, g, b, a)


cpdef cgraphics.Color Color_cast(value):
    if utils.is_iterable(value):
        if len(value) == 3:
            return Color_from_rgb(*value)
        else:
            return Color_from_rgba(*value)
    else:
        return value


cpdef tuple Color_unpack_rgb(cgraphics.Color color):
    return color.r, color.g, color.b


cpdef tuple Color_unpack_rgba(cgraphics.Color color):
    return color.r, color.g, color.b, color.a


# Color_add


cpdef tuple Color_add(color1, color2):
    return Color_unpack_rgba(cgraphics.Color_add(Color_cast(color1), Color_cast(color2)))


cpdef cgraphics.Color Color_add_struct(cgraphics.Color color1, cgraphics.Color color2):
    return cgraphics.Color_add(color1, color2)


cpdef tuple Color_add_rgb(
        Uint8 r1, Uint8 g1, Uint8 b1,
        Uint8 r2, Uint8 g2, Uint8 b2):
    return Color_unpack_rgb(
        cgraphics.Color_add(
            Color_from_rgb(r1, g1, b1),
            Color_from_rgb(r2, g2, b2),
        ),
    )


cpdef tuple Color_add_rgba(
        Uint8 r1, Uint8 g1, Uint8 b1, Uint8 a1,
        Uint8 r2, Uint8 g2, Uint8 b2, Uint8 a2):
    return Color_unpack_rgba(
        cgraphics.Color_add(
            Color_from_rgba(r1, g1, b1, a1),
            Color_from_rgba(r2, g2, b2, a2),
        ),
    )


# Color_modulate


cpdef tuple Color_modulate(color1, color2):
    return Color_unpack_rgba(cgraphics.Color_modulate(Color_cast(color1), Color_cast(color2)))


cpdef cgraphics.Color Color_modulate_struct(cgraphics.Color color1, cgraphics.Color color2):
    return cgraphics.Color_modulate(color1, color2)


cpdef tuple Color_modulate_rgb(
        Uint8 r1, Uint8 g1, Uint8 b1,
        Uint8 r2, Uint8 g2, Uint8 b2):
    return Color_unpack_rgb(
        cgraphics.Color_modulate(
            Color_from_rgb(r1, g1, b1),
            Color_from_rgb(r2, g2, b2),
        ),
    )


cpdef tuple Color_modulate_rgba(
        Uint8 r1, Uint8 g1, Uint8 b1, Uint8 a1,
        Uint8 r2, Uint8 g2, Uint8 b2, Uint8 a2):
    return Color_unpack_rgba(
        cgraphics.Color_modulate(
            Color_from_rgba(r1, g1, b1, a1),
            Color_from_rgba(r2, g2, b2, a2),
        ),
    )


# Vertex
################################################################################

cpdef cgraphics.Vertex Vertex_cast(value): #position, color, tex_coords):
    if not utils.is_iterable(value):
        return value
    cdef cgraphics.Vertex vertex
    vertex.position = system.Vector2f_cast(value[0])
    vertex.color = Color_cast(value[1])
    vertex.tex_coords = system.Vector2f_cast(value[2])
    return vertex


cpdef cgraphics.Vertex Vertex(
        csystem.Vector2f position,
        cgraphics.Color color,
        csystem.Vector2f tex_coords=system.Vector2f(0, 0)):
    cdef cgraphics.Vertex vertex
    vertex.position = position
    vertex.color = color
    vertex.tex_coords = tex_coords
    return vertex


cpdef cgraphics.Vertex Vertex_from_args(float x, float y, Uint8 r, Uint8 g, Uint8 b, Uint8 a, float tex_x=0, float tex_y=0):
    cdef cgraphics.Vertex vertex
    vertex.position = system.Vector2f(x, y)
    vertex.color = Color_from_rgba(r, g, b, a)
    vertex.tex_coords = system.Vector2f(tex_x, tex_y)
    return vertex


cpdef tuple Vertex_unpack(cgraphics.Vertex vertex):
    return (
        system.Vector2f_unpack(vertex.position),
        Color_unpack_rgba(vertex.color),
        system.Vector2f_unpack(vertex.tex_coords),
    )


# Transform
################################################################################


cdef class TransformWrapper:
    '''
    Q: Does this need a class?    
    '''
    # Python constructors
    
    @staticmethod
    def from_matrix(
            float a00, float a01, float a02,
            float a10, float a11, float a12,
            float a20, float a21, float a22):
        cdef cgraphics.Transform transform = cgraphics.Transform_from_matrix(
            a00, a01, a02,
            a10, a11, a12,
            a20, a21, a22,
        )
        return Transform_wrap_ptr(&transform)

    # Attributes
    
    # inverse
    
    cpdef TransformWrapper get_inverse(TransformWrapper self):
        cdef cgraphics.Transform transform = cgraphics.Transform_get_inverse(self.Transform)
        return Transform_wrap_ptr(&transform)
    
    cdef cgraphics.Transform get_inverse_struct(TransformWrapper self):
        return cgraphics.Transform_get_inverse(self.Transform)
    
    property inverse:
        def __get__(TransformWrapper self):
            cdef cgraphics.Transform transform = cgraphics.Transform_get_inverse(self.Transform)
            return Transform_wrap_ptr(&transform)
    
    # matrix
    
    cpdef tuple get_matrix(TransformWrapper self):
        cdef float m[16]
        cgraphics.Transform_get_matrix(self.Transform, m)
        return (
            m[0], m[1], m[2], m[3],
            m[4], m[5], m[6], m[7],
            m[8], m[9], m[10], m[11],
            m[12], m[13], m[14], m[15],
        )
    
    cdef float* get_matrix_array(TransformWrapper self):
        cdef float m[16]
        cgraphics.Transform_get_matrix(self.Transform, m)
        return m
    
    property matrix:
        def __get__(TransformWrapper self):
            return self.get_matrix()
    
    # Cython methods
    
    # transform_rect
    
    cpdef tuple transform_rect(TransformWrapper self, rect):
        return FloatRect_unpack(cgraphics.Transform_transform_rect(self.Transform, FloatRect_cast(rect)))
    
    cpdef cgraphics.FloatRect transform_rect_struct(TransformWrapper self, cgraphics.FloatRect rect):
        return cgraphics.Transform_transform_rect(self.Transform, rect)
    
    cpdef tuple transform_rect_ltwh(TransformWrapper self, float left, float top, float width, float height):
        return FloatRect_unpack(cgraphics.Transform_transform_rect(self.Transform, FloatRect(left, top, width, height)))
    
    # combine
    
    cpdef combine(TransformWrapper self, TransformWrapper transform):
        cgraphics.Transform_combine(self.Transform, transform.Transform)
    
    cdef combine_struct(TransformWrapper self, cgraphics.Transform transform):
        cgraphics.Transform_combine(self.Transform, &transform)
    
    cpdef translate(TransformWrapper self, float x, float y):
        cgraphics.Transform_translate(self.Transform, x, y)
    
    cpdef rotate(TransformWrapper self, float angle):
        cgraphics.Transform_rotate(self.Transform, angle)
    
    cpdef rotate_with_center(TransformWrapper self, float angle, float x, float y):
        cgraphics.Transform_rotate_with_center(self.Transform, angle, x, y)
    
    cpdef scale(TransformWrapper self, float scale_x, float scale_y):
        cgraphics.Transform_scale(self.Transform, scale_x, scale_y)
    
    cpdef scale_with_center(TransformWrapper self, float scale_x, float scale_y, float center_x, float center_y):
        cgraphics.Transform_scale_with_center(self.Transform, scale_x, scale_y, center_x, center_y)


cdef class Transform(TransformWrapper):
    def __cinit__(TransformWrapper self):
        self.Transform = &cgraphics.TRANSFORM_IDENTITY


cdef TransformWrapper Transform_wrap_ptr(cgraphics.Transform* transform_ptr):
    cdef TransformWrapper transform = TransformWrapper()
    transform.Transform = transform_ptr
    return transform


cdef TransformWrapper Transform_create():
    return Transform_wrap_ptr(&cgraphics.TRANSFORM_IDENTITY)


cdef TransformWrapper Transform_from_matrix(
        float a00, float a01, float a02,
        float a10, float a11, float a12,
        float a20, float a21, float a22):
    cdef cgraphics.Transform transform = cgraphics.Transform_from_matrix(
        a00, a01, a02,
        a10, a11, a12,
        a20, a21, a22,
    )
    return Transform_wrap_ptr(&transform)


# Transformable
#################################################################################

cdef class TransformableWrapper:
    
    # Special methods
    
    def __dealloc__(TransformableWrapper self):
        if self.Transformable:
            cgraphics.Transformable_destroy(self.Transformable)
    
    # Cython methods
    
    cpdef destroy(TransformableWrapper self):
        if self.Transformable:
            cgraphics.Transformable_destroy(self.Transformable)
            self.Transformable = NULL
    
    cpdef TransformableWrapper copy(TransformableWrapper self):
        Transformable_wrap_ptr(cgraphics.Transformable_copy(self.Transformable))
    
    # move
    
    cpdef move(TransformableWrapper self, offset):
        cgraphics.Transformable_move(self.Transformable, system.Vector2f_cast(offset))
    
    cpdef move_struct(TransformableWrapper self, csystem.Vector2f offset):
        cgraphics.Transformable_move(self.Transformable, offset)
    
    cpdef move_xy(TransformableWrapper self, float x, float y):
        cgraphics.Transformable_move(self.Transformable, system.Vector2f(x, y))
    
    # rotate
    
    cpdef rotate(TransformableWrapper self, float angle):
        cgraphics.Transformable_rotate(self.Transformable, angle)
    
    # scale_relative
    
    cpdef scale_relative(TransformableWrapper self, scale):
        cgraphics.Transformable_scale(self.Transformable, system.Vector2f_cast(scale))
    
    cpdef scale_relative_struct(TransformableWrapper self, csystem.Vector2f scale):
        cgraphics.Transformable_scale(self.Transformable, scale)
    
    cpdef scale_relative_xy(TransformableWrapper self, float x, float y):
        cgraphics.Transformable_scale(self.Transformable, system.Vector2f(x, y))
    
    # Attributes
    
    # position
    
    cpdef tuple get_position(TransformableWrapper self):
        return system.Vector2f_unpack(cgraphics.Transformable_get_position(self.Transformable))
    
    cpdef csystem.Vector2f get_position_struct(TransformableWrapper self):
        return cgraphics.Transformable_get_position(self.Transformable)
    
    cpdef tuple get_position_xy(TransformableWrapper self):
        return system.Vector2f_unpack(cgraphics.Transformable_get_position(self.Transformable))
    
    cpdef set_position(TransformableWrapper self, position):
        cgraphics.Transformable_set_position(self.Transformable, system.Vector2f_cast(position))
    
    cpdef set_position_struct(TransformableWrapper self, csystem.Vector2f position):
        cgraphics.Transformable_set_position(self.Transformable, position)
    
    cpdef set_position_xy(TransformableWrapper self, float x, float y):
        cgraphics.Transformable_set_position(self.Transformable, system.Vector2f(x, y))
    
    property position:
        def __get__(TransformableWrapper self):
            return system.Vector2f_unpack(cgraphics.Transformable_get_position(self.Transformable))
        
        def __set__(TransformableWrapper self, position):
            cgraphics.Transformable_set_position(self.Transformable, system.Vector2f_cast(position))

    # rotation
    
    cpdef float get_rotation(TransformableWrapper self):
        return cgraphics.Transformable_get_rotation(self.Transformable)
    
    cpdef set_rotation(TransformableWrapper self, float angle):
        cgraphics.Transformable_set_rotation(self.Transformable, angle)
    
    property rotation:
        def __get__(TransformableWrapper self):
            return cgraphics.Transformable_get_rotation(self.Transformable)
        
        def __set__(TransformableWrapper self, float angle):
            cgraphics.Transformable_set_rotation(self.Transformable, angle)
    
    # scale
    
    cpdef tuple get_scale(TransformableWrapper self):
        return system.Vector2f_unpack(cgraphics.Transformable_get_scale(self.Transformable))
    
    cpdef csystem.Vector2f get_scale_struct(TransformableWrapper self):
        return cgraphics.Transformable_get_scale(self.Transformable)
    
    cpdef tuple get_scale_xy(TransformableWrapper self):
        return system.Vector2f_unpack(cgraphics.Transformable_get_scale(self.Transformable))
    
    cpdef set_scale(TransformableWrapper self, scale):
        cgraphics.Transformable_set_scale(self.Transformable, system.Vector2f_cast(scale))
    
    cpdef set_scale_struct(TransformableWrapper self, csystem.Vector2f scale):
        cgraphics.Transformable_set_scale(self.Transformable, scale)
    
    cpdef set_scale_xy(TransformableWrapper self, float x, float y):
        cgraphics.Transformable_set_scale(self.Transformable, system.Vector2f(x, y))
    
    property scale:
        def __get__(TransformableWrapper self):
            return system.Vector2f_unpack(cgraphics.Transformable_get_scale(self.Transformable))
        
        def __set__(TransformableWrapper self, scale):
            cgraphics.Transformable_set_scale(self.Transformable, system.Vector2f_cast(scale))
    
    # origin
    
    cpdef set_origin(TransformableWrapper self, origin):
        cgraphics.Transformable_set_origin(self.Transformable, system.Vector2f_cast(origin))
    
    cpdef set_origin_struct(TransformableWrapper self, csystem.Vector2f origin):
        cgraphics.Transformable_set_origin(self.Transformable, origin)
    
    cpdef set_origin_xy(TransformableWrapper self, float x, float y):
        cgraphics.Transformable_set_origin(self.Transformable, system.Vector2f(x, y))
    
    cpdef tuple get_origin(TransformableWrapper self):
        return system.Vector2f_unpack(cgraphics.Transformable_get_origin(self.Transformable))
    
    cpdef csystem.Vector2f get_origin_struct(TransformableWrapper self):
        return cgraphics.Transformable_get_origin(self.Transformable)
    
    cpdef tuple get_origin_xy(TransformableWrapper self):
        return system.Vector2f_unpack(cgraphics.Transformable_get_origin(self.Transformable))
    
    property origin:
        def __get__(TransformableWrapper self):
            return system.Vector2f_unpack(cgraphics.Transformable_get_origin(self.Transformable))
        
        def __set__(TransformableWrapper self, origin):
            cgraphics.Transformable_set_origin(self.Transformable, system.Vector2f_cast(origin))
    
    # transform
    
    cpdef Transform get_transform(TransformableWrapper self):
        cdef cgraphics.Transform transform = cgraphics.Transformable_get_transform(self.Transformable)
        return Transform_wrap_ptr(&transform)
    
    cdef cgraphics.Transform get_transform_struct(TransformableWrapper self):
        '''
        Returns a Transform struct. Faster than wrapping with a Cython Extension class.
        '''
        return cgraphics.Transformable_get_transform(self.Transformable)
    
    property transform:
        def __get__(TransformableWrapper self):
            return self.get_transform()
    
    # inverse_transform
    
    cpdef Transform get_inverse_transform(TransformableWrapper self):
        cdef cgraphics.Transform transform = cgraphics.Transformable_get_inverse_transform(self.Transformable)
        return Transform_wrap_ptr(&transform)
    
    cdef cgraphics.Transform get_inverse_transform_struct(TransformableWrapper self):
        '''
        Returns the inverse Transform struct. Faster than wrapping with a Cython Extension class.
        '''
        return cgraphics.Transformable_get_inverse_transform(self.Transformable)
    
    property inverse_transform:
        def __get__(TransformableWrapper self):
            return self.get_inverse_transform()


cdef class Transformable(TransformableWrapper):
    def __cinit__(Transformable self):
        self.Transformable = cgraphics.Transformable_create()


cdef TransformableWrapper Transformable_wrap_ptr(cgraphics.Transformable* transformable_ptr):
    cdef TransformableWrapper transformable = TransformableWrapper()
    transformable.Transformable = transformable_ptr
    return transformable


cdef TransformableWrapper Transformable_create():
    return Transformable_wrap_ptr(cgraphics.Transformable_create())



# Image
################################################################################

cdef ImageWrapper Image_wrap_ptr(cgraphics.Image* image_ptr):
    cdef ImageWrapper image = ImageWrapper()
    image.Image = image_ptr
    return image


cdef ImageWrapper Image_create(unsigned int width, unsigned int height):
    return Image_wrap_ptr(cgraphics.Image_create(width, height))


cdef ImageWrapper Image_from_pixels(unsigned int width, unsigned int height, const Uint8* pixels):
    return Image_wrap_ptr(cgraphics.Image_create_from_pixels(width, height, pixels))


cdef ImageWrapper Image_from_color(unsigned int width, unsigned int height, color):
    return Image_wrap_ptr(cgraphics.Image_create_from_color(width, height, Color_cast(color)))


cdef ImageWrapper Image_from_color_struct(unsigned int width, unsigned int height, cgraphics.Color color):
    return Image_wrap_ptr(cgraphics.Image_create_from_color(width, height, color))


cdef ImageWrapper Image_from_color_rgb(unsigned int width, unsigned int height, Uint8 r, Uint8 g, Uint8 b):
    return Image_wrap_ptr(cgraphics.Image_create_from_color(width, height, Color_from_rgb(r, g, b)))


cdef ImageWrapper Image_from_color_rgba(unsigned int width, unsigned int height, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
    return Image_wrap_ptr(cgraphics.Image_create_from_color(width, height, Color_from_rgba(r, g, b, a)))


cdef ImageWrapper Image_from_file(const char* filename):
    return Image_wrap_ptr(cgraphics.Image_create_from_file(filename))


cdef ImageWrapper Image_from_memory(const void* data, size_t size):
    return Image_wrap_ptr(cgraphics.Image_create_from_memory(data, size))


cdef ImageWrapper Image_from_stream(system.InputStream stream):
    return Image_wrap_ptr(cgraphics.Image_create_from_stream(stream.InputStream))


cdef class ImageWrapper:
    
    # Python constructors
    
    @staticmethod
    def from_pixels(unsigned int width, unsigned int height, const Uint8* pixels):
        return Image_wrap_ptr(cgraphics.Image_create_from_pixels(width, height, pixels))
    
    @staticmethod
    def from_color(unsigned int width, unsigned int height, color):
        return Image_wrap_ptr(cgraphics.Image_create_from_color(width, height, Color_cast(color)))
    
    @staticmethod
    def from_color_struct(unsigned int width, unsigned int height, cgraphics.Color color):
        return Image_wrap_ptr(cgraphics.Image_create_from_color(width, height, color))
    
    @staticmethod
    def from_color_rgb(unsigned int width, unsigned int height, Uint8 r, Uint8 g, Uint8 b):
        return Image_wrap_ptr(cgraphics.Image_create_from_color(width, height, Color_from_rgb(r, g, b)))
    
    @staticmethod
    def from_color_rgba(unsigned int width, unsigned int height, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        return Image_wrap_ptr(cgraphics.Image_create_from_color(width, height, Color_from_rgba(r, g, b, a)))
    
    @staticmethod
    def from_file(const char* filename):
        return Image_wrap_ptr(cgraphics.Image_create_from_file(filename))
    
    @staticmethod
    def from_stream(system.InputStream stream):
        return Image_wrap_ptr(cgraphics.Image_create_from_stream(stream.InputStream))
    
    # Cython methods
    
    cpdef destroy(ImageWrapper self):
        if self.Image:
            cgraphics.Image_destroy(self.Image)
            self.Image = NULL
    
    cpdef ImageWrapper copy(ImageWrapper self):
        return Image_wrap_ptr(cgraphics.Image_copy(self.Image))
    
    cpdef copy_image(ImageWrapper self, ImageWrapper source, unsigned int dest_x, unsigned int dest_y, source_rect, bint apply_alpha):
        cgraphics.Image_copy_image(self.Image, source.Image, dest_x, dest_y, IntRect_cast(source_rect), apply_alpha)
    
    cpdef copy_image_struct(ImageWrapper self, ImageWrapper source, unsigned int dest_x, unsigned int dest_y, cgraphics.IntRect source_rect, bint apply_alpha):
        cgraphics.Image_copy_image(self.Image, source.Image, dest_x, dest_y, source_rect, apply_alpha)
    
    cpdef copy_image_ltwh(ImageWrapper self,
            ImageWrapper source,
            unsigned int dest_x,
            unsigned int dest_y,
            int source_left,
            int source_top,
            int source_width,
            int source_height,
            bint apply_alpha):
        cgraphics.Image_copy_image(
            self.Image,
            source.Image,
            dest_x,
            dest_y,
            IntRect(
                source_left,
                source_top,
                source_width,
                source_height,
            ),
            apply_alpha,
        )
    
    cpdef save_to_file(ImageWrapper self, const char* filename):
        cgraphics.Image_save_to_file(self.Image, filename)
    
    # create_mask_from_color
    
    cpdef create_mask_from_color(ImageWrapper self, color, Uint8 alpha):
        cgraphics.Image_create_mask_from_color(self.Image, Color_cast(color), alpha)
    
    cpdef create_mask_from_color_struct(ImageWrapper self, cgraphics.Color color, Uint8 alpha):
        cgraphics.Image_create_mask_from_color(self.Image, color, alpha)
    
    cpdef create_mask_from_color_rgb(ImageWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 alpha):
        cgraphics.Image_create_mask_from_color(self.Image, Color_from_rgb(r, g, b), alpha)
    
    cpdef create_mask_from_color_rgba(ImageWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a, Uint8 alpha):
        cgraphics.Image_create_mask_from_color(self.Image, Color_from_rgba(r, g, b, a), alpha)
    
    cpdef set_pixel(ImageWrapper self, unsigned int x, unsigned int y, color):
        cgraphics.Image_set_pixel(self.Image, x, y, Color_cast(color))
    
    cpdef set_pixel_struct(ImageWrapper self, unsigned int x, unsigned int y, cgraphics.Color color):
        cgraphics.Image_set_pixel(self.Image, x, y, color)
    
    cpdef set_pixel_rgb(ImageWrapper self, unsigned int x, unsigned int y, Uint8 r, Uint8 g, Uint8 b):
        self.set_pixel(x, y, Color_from_rgb(r, g, b))
    
    cpdef set_pixel_rgba(ImageWrapper self, unsigned int x, unsigned int y, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        self.set_pixel(x, y, Color_from_rgba(r, g, b, a))
    
    cpdef cgraphics.Color get_pixel(ImageWrapper self, unsigned int x, unsigned int y):
        return cgraphics.Image_get_pixel(self.Image, x, y)
    
    cpdef tuple get_pixel_rgb(ImageWrapper self, unsigned int x, unsigned int y):
        return Color_unpack_rgb(self.get_pixel(x, y))
    
    cpdef tuple get_pixel_rgba(ImageWrapper self, unsigned int x, unsigned int y):
        return Color_unpack_rgba(self.get_pixel(x, y))
    
    #cpdef Uint8* get_pixels(ImageWrapper self):
        #return cgraphics.Image_get_pixels_ptr(self.Image)
    
    cpdef flip_horizontally(ImageWrapper self):
        cgraphics.Image_flip_horizontally(self.Image)
    
    cpdef flip_vertically(ImageWrapper self):
        cgraphics.Image_flip_vertically(self.Image)
    
    # Attributes
    
    # size
    
    cpdef tuple get_size(ImageWrapper self):
        return system.Vector2u_unpack(cgraphics.Image_get_size(self.Image))
    
    cpdef csystem.Vector2u get_size_struct(ImageWrapper self):
        return cgraphics.Image_get_size(self.Image)
    
    cpdef tuple get_size_xy(ImageWrapper self):
        return system.Vector2u_unpack(cgraphics.Image_get_size(self.Image))
    
    property size:
        def __get__(ImageWrapper self):
            return system.Vector2u_unpack(cgraphics.Image_get_size(self.Image))
    
    # Special methods
    
    def __dealloc__(ImageWrapper self):
        if self.Image:
            cgraphics.Image_destroy(self.Image)


cdef class Image(ImageWrapper):
    def __cinit__(Image self, unsigned int width, unsigned int height):
        self.Image = cgraphics.Image_create(width, height)


# Texture
################################################################################

cdef TextureWrapper Texture_wrap_ptr(cgraphics.Texture* texture_ptr):
    cdef TextureWrapper texture = TextureWrapper()
    texture.Texture = texture_ptr
    return texture


cdef TextureWrapper Texture_create(unsigned int width, unsigned int height):
    return Texture_wrap_ptr(cgraphics.Texture_create(width, height))


cdef TextureWrapper Texture_from_file(const char* filename):
    return Texture_wrap_ptr(cgraphics.Texture_create_from_file(filename, NULL))


cdef TextureWrapper Texture_from_file_area(const char* filename, area):
    cdef cgraphics.IntRect rect = IntRect_cast(area)
    return Texture_wrap_ptr(cgraphics.Texture_create_from_file(filename, &rect))


cdef TextureWrapper Texture_from_file_area_struct(const char* filename, const cgraphics.IntRect area):
    return Texture_wrap_ptr(cgraphics.Texture_create_from_file(filename, &area))


cdef TextureWrapper Texture_from_file_area_ltwh(const char* filename, int left, int top, int width, int height):
    cdef cgraphics.IntRect rect = IntRect(left, top, width, height)
    return Texture_wrap_ptr(cgraphics.Texture_create_from_file(filename, &rect))


cdef TextureWrapper Texture_from_file_area_ptr(const char* filename, const cgraphics.IntRect* area):
    return Texture_wrap_ptr(cgraphics.Texture_create_from_file(filename, area))


cdef TextureWrapper Texture_from_memory(const void* data, size_t size_in_bytes, cgraphics.IntRect* area):
    return Texture_wrap_ptr(cgraphics.Texture_create_from_memory(data, size_in_bytes, area))


cdef class TextureWrapper:
    
    # Python constructors
    
    @staticmethod
    def from_file(const char* filename):
        return Texture_wrap_ptr(cgraphics.Texture_create_from_file(filename, NULL))
    
    @staticmethod
    def from_file_area(const char* filename, area):
        cdef cgraphics.IntRect rect = IntRect_cast(area)
        return Texture_wrap_ptr(cgraphics.Texture_create_from_file(filename, &rect))
    
    @staticmethod
    def from_file_area_struct(const char* filename, const cgraphics.IntRect rect):
        return Texture_wrap_ptr(cgraphics.Texture_create_from_file(filename, &rect))
    
    @staticmethod
    def from_file_area_ltwh(const char* filename, int left, int top, int width, int height):
        cdef cgraphics.IntRect rect = IntRect(left, top, width, height)
        return Texture_wrap_ptr(cgraphics.Texture_create_from_file(filename, &rect))
    
    @staticmethod
    def from_file_area_ltwh(const char* filename, int left, int top, int width, int height):
        cdef cgraphics.IntRect rect = IntRect(left, top, width, height)
        return Texture_wrap_ptr(cgraphics.Texture_create_from_file(filename, &rect))
    
    # Python methods
    
    @staticmethod
    def get_maximum_size():
        return cgraphics.Texture_get_maximum_size()
    
    # Cython methods
    
    cpdef destroy(TextureWrapper self):
        # Do we want to automatically deallocate?
        if self.Texture:
            cgraphics.Texture_destroy(self.Texture)
            self.Texture = NULL
    
    cpdef TextureWrapper copy(TextureWrapper self):
        return Texture_wrap_ptr(cgraphics.Texture_copy(self.Texture))
    
    cdef update_from_pixels(TextureWrapper self, const Uint8* pixels, unsigned int width, unsigned int height, unsigned int x, unsigned int y):
        cgraphics.Texture_update_from_pixels(self.Texture, pixels, width, height, x, y)
    
    cpdef update_from_image(TextureWrapper self, ImageWrapper image, unsigned int x, unsigned int y):
        cgraphics.Texture_update_from_image(self.Texture, image.Image, x, y)
    
    cpdef update_from_window(TextureWrapper self, window.WindowWrapper window, unsigned int x, unsigned int y):
        cgraphics.Texture_update_from_window(self.Texture, window.Window, x, y)
    
    #cpdef update_from_render_window(TextureWrapper self, RenderWindowWrapper render_window, unsigned int x, unsigned int y):
        #cgraphics.Texture_update_from_render_window(self.Texture, render_window.RenderWindow, x, y)
    
    cpdef ImageWrapper copy_to_image(TextureWrapper self):
        return Image_wrap_ptr(cgraphics.Texture_copy_to_image(self.Texture))
    
    cpdef bind(TextureWrapper self):
        cgraphics.Texture_bind(self.Texture)
    
    # Attributes
    
    # size
    
    cpdef tuple get_size(TextureWrapper self):
        return system.Vector2u_unpack(cgraphics.Texture_get_size(self.Texture))
    
    cpdef csystem.Vector2u get_size_struct(TextureWrapper self):
        return cgraphics.Texture_get_size(self.Texture)
    
    cpdef tuple get_size_xy(TextureWrapper self):
        return system.Vector2u_unpack(cgraphics.Texture_get_size(self.Texture))
    
    property size:
        def __get__(TextureWrapper self):
            return system.Vector2u_unpack(cgraphics.Texture_get_size(self.Texture))
    
    # width
    
    cpdef unsigned int get_width(TextureWrapper self):
        return cgraphics.Texture_get_size(self.Texture).x
    
    # height
    
    cpdef unsigned int get_height(TextureWrapper self):
        return cgraphics.Texture_get_size(self.Texture).y
    
    # smooth
    
    cpdef bint is_smooth(TextureWrapper self):
        return cgraphics.Texture_is_smooth(self.Texture)
    
    cpdef set_smooth(TextureWrapper self, bint smooth):
        cgraphics.Texture_set_smooth(self.Texture, smooth)
    
    property smooth:
        def __get__(TextureWrapper self):
            return cgraphics.Texture_is_smooth(self.Texture)
        
        def __set__(TextureWrapper self, bint smooth):
            cgraphics.Texture_set_smooth(self.Texture, smooth)
    
    # repeated
    
    cpdef bint is_repeated(TextureWrapper self):
        return cgraphics.Texture_is_repeated(self.Texture)
    
    cpdef set_repeated(TextureWrapper self, bint repeated):
        cgraphics.Texture_set_repeated(self.Texture, repeated)
    
    property repeated:
        def __get__(TextureWrapper self):
            return cgraphics.Texture_is_repeated(self.Texture)
        
        def __set__(TextureWrapper self, bint repeated):
            cgraphics.Texture_set_repeated(self.Texture, repeated)
    
    # Special methods
    
    #def __dealloc__(TextureWrapper self):
        ## Do we want to automatically deallocate?
        #if self.Texture:
            #cgraphics.Texture_destroy(self.Texture)


cdef class Texture(TextureWrapper):
    def __cinit__(TextureWrapper self, unsigned int width, unsigned int height):
        self.Texture = cgraphics.Texture_create(width, height)


cdef unsigned int Texture_get_maximum_size():
    return cgraphics.Texture_get_maximum_size()


# Drawable
################################################################################

cdef class Drawable:
    cpdef draw(Drawable self, RenderWindowWrapper window):
        pass
    
    cdef draw_transform_struct(Drawable self, RenderWindowWrapper window, cgraphics.Transform transform):
        pass


# VertexArray
################################################################################

cdef class VertexArrayWrapper(Drawable):
    
    # Cython methods
    
    cpdef destroy(VertexArrayWrapper self):
        if self.VertexArray:
            cgraphics.VertexArray_destroy(self.VertexArray)
            self.VertexArray = NULL
    
    cpdef VertexArrayWrapper copy(VertexArrayWrapper self):
        return VertexArray_wrap_ptr(cgraphics.VertexArray_copy(self.VertexArray))
    
    cpdef clear(VertexArrayWrapper self):
        cgraphics.VertexArray_clear(self.VertexArray)
    
    cpdef resize(VertexArrayWrapper self, unsigned int vertex_count):
        cgraphics.VertexArray_resize(self.VertexArray, vertex_count)
    
    # append
    
    cpdef append(VertexArrayWrapper self, vertex):
        cgraphics.VertexArray_append(self.VertexArray, Vertex_cast(vertex))
    
    cpdef append_struct(VertexArrayWrapper self, cgraphics.Vertex vertex):
        cgraphics.VertexArray_append(self.VertexArray, vertex)
    
    cpdef append_args(VertexArrayWrapper self, float x, float y, Uint8 r, Uint8 g, Uint8 b, Uint8 a, float tex_x=0, float tex_y=0):
        cgraphics.VertexArray_append(self.VertexArray, Vertex_from_args(x, y, r, g, b, a, tex_x, tex_y))
    
    # get_vertex
    
    cpdef tuple get_vertex(VertexArrayWrapper self, unsigned int index):
        cdef cgraphics.Vertex vertex
        vertex = cgraphics.VertexArray_get_vertex(self.VertexArray, index)[0]
        return Vertex_unpack(vertex)
    
    cpdef cgraphics.Vertex get_vertex_struct(VertexArrayWrapper self, unsigned int index):
        cdef cgraphics.Vertex vertex
        vertex = cgraphics.VertexArray_get_vertex(self.VertexArray, index)[0]
        return vertex
    
    # Attributes
    
    # vertex_count
    
    cpdef unsigned int get_vertex_count(VertexArrayWrapper self):
        return cgraphics.VertexArray_get_vertex_count(self.VertexArray)
    
    property vertex_count:
        def __get__(VertexArrayWrapper self):
            return cgraphics.VertexArray_get_vertex_count(self.VertexArray)
    
    # primitive_type
    
    cpdef cgraphics.PrimitiveType get_primitive_type(VertexArrayWrapper self):
        return cgraphics.VertexArray_get_primitive_type(self.VertexArray)
    
    cpdef set_primitive_type(VertexArrayWrapper self, cgraphics.PrimitiveType type):
        cgraphics.VertexArray_set_primitive_type(self.VertexArray, type)
    
    property primitive_type:
        def __get__(VertexArrayWrapper self):
            return cgraphics.VertexArray_get_primitive_type(self.VertexArray)
        
        def __set__(VertexArrayWrapper self, cgraphics.PrimitiveType type):
            cgraphics.VertexArray_set_primitive_type(self.VertexArray, type)
    
    # drawing
    
    cpdef draw(VertexArrayWrapper self, RenderWindowWrapper render_window):
        cgraphics.RenderWindow_draw_vertex_array(render_window.RenderWindow, self.VertexArray, RENDER_STATES_DEFAULT_PTR)
    
    cdef draw_transform_struct(VertexArrayWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform):
        cdef cgraphics.RenderStates render_states
        render_states.blend_mode = cgraphics.BLEND_ALPHA
        render_states.transform = transform
        render_states.texture = NULL
        render_states.shader = NULL
        
        cgraphics.RenderWindow_draw_vertex_array(
            render_window.RenderWindow,
            self.VertexArray,
            &render_states,
        )
    
    # bounds
    
    cpdef tuple get_bounds(VertexArrayWrapper self):
        return FloatRect_unpack(cgraphics.VertexArray_get_bounds(self.VertexArray))
    
    cpdef cgraphics.FloatRect get_bounds_struct(VertexArrayWrapper self):
        return cgraphics.VertexArray_get_bounds(self.VertexArray)
    
    cpdef tuple get_bounds_ltwh(VertexArrayWrapper self):
        return FloatRect_unpack(cgraphics.VertexArray_get_bounds(self.VertexArray))
    
    property bounds:
        def __get__(VertexArrayWrapper self):
            return FloatRect_unpack(cgraphics.VertexArray_get_bounds(self.VertexArray))
    
    # Special methods
    
    def __dealloc__(VertexArrayWrapper self):
        cgraphics.VertexArray_destroy(self.VertexArray)
    
    def __len__(VertexArrayWrapper self):
        return self.get_vertex_count()
    
    def __getitem__(VertexArrayWrapper self, unsigned int index):
        return self.get_vertex(index)


cdef class VertexArray(VertexArrayWrapper):
    def __cinit__(VertexArray self, cgraphics.PrimitiveType primitive_type):
        self.VertexArray = cgraphics.VertexArray_create()
        if primitive_type != 0:
            cgraphics.VertexArray_set_primitive_type(self.VertexArray, primitive_type)


cdef VertexArrayWrapper VertexArray_wrap_ptr(cgraphics.VertexArray* vertex_array_ptr):
    cdef VertexArrayWrapper vertex_array = VertexArrayWrapper()
    vertex_array.VertexArray = vertex_array_ptr
    return vertex_array


cdef VertexArrayWrapper VertexArray_create():
    return VertexArray_wrap_ptr(cgraphics.VertexArray_create())



# Shape
################################################################################

cdef class ShapeWrapper(Drawable):
    
    # Special methods
    
    def __dealloc__(ShapeWrapper self):
        cgraphics.Shape_destroy(self.Shape)
    
    def __getitem__(ShapeWrapper self, int index):
        return system.Vector2f_unpack(cgraphics.Shape_get_point(self.Shape, index))
    
    # Attributes
    
    # position
    
    cpdef tuple get_position(ShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.Shape_get_position(self.Shape))
    
    cpdef csystem.Vector2f get_position_struct(ShapeWrapper self):
        return cgraphics.Shape_get_position(self.Shape)
    
    cpdef tuple get_position_xy(ShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.Shape_get_position(self.Shape))
    
    cpdef set_position(ShapeWrapper self, position):
        cgraphics.Shape_set_position(self.Shape, system.Vector2f_cast(position))
    
    cpdef set_position_struct(ShapeWrapper self, csystem.Vector2f position):
        cgraphics.Shape_set_position(self.Shape, position)
    
    cpdef set_position_xy(ShapeWrapper self, float x, float y):
        cgraphics.Shape_set_position(self.Shape, system.Vector2f(x, y))
    
    property position:
        def __get__(ShapeWrapper self):
            return system.Vector2f_unpack(cgraphics.Shape_get_position(self.Shape))
        
        def __set__(ShapeWrapper self, position):
            cgraphics.Shape_set_position(self.Shape, system.Vector2f_cast(position))
    
    # rotation
    
    cpdef float get_rotation(ShapeWrapper self):
        return cgraphics.Shape_get_rotation(self.Shape)
    
    cpdef set_rotation(ShapeWrapper self, float angle):
        cgraphics.Shape_set_rotation(self.Shape, angle)
    
    property rotation:
        def __get__(ShapeWrapper self):
            return cgraphics.Shape_get_rotation(self.Shape)
        
        def __set__(ShapeWrapper self, float angle):
            cgraphics.Shape_set_rotation(self.Shape, angle)
    
    # scale
    
    cpdef tuple get_scale(ShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.Shape_get_scale(self.Shape))
    
    cpdef csystem.Vector2f get_scale_struct(ShapeWrapper self):
        return cgraphics.Shape_get_scale(self.Shape)
    
    cpdef tuple get_scale_xy(ShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.Shape_get_scale(self.Shape))
    
    cpdef set_scale(ShapeWrapper self, scale):
        cgraphics.Shape_set_scale(self.Shape, system.Vector2f_cast(scale))
    
    cpdef set_scale_struct(ShapeWrapper self, csystem.Vector2f scale):
        cgraphics.Shape_set_scale(self.Shape, scale)
    
    cpdef set_scale_xy(ShapeWrapper self, float x, float y):
        cgraphics.Shape_set_scale(self.Shape, system.Vector2f(x, y))
    
    property scale:
        def __get__(ShapeWrapper self):
            return system.Vector2f_unpack(cgraphics.Shape_get_scale(self.Shape))
        
        def __set__(ShapeWrapper self, scale):
            cgraphics.Shape_set_scale(self.Shape, system.Vector2f_cast(scale))
    
    # origin
    
    cpdef tuple get_origin(ShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.Shape_get_origin(self.Shape))
    
    cpdef csystem.Vector2f get_origin_struct(ShapeWrapper self):
        return cgraphics.Shape_get_origin(self.Shape)
    
    cpdef tuple get_origin_xy(ShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.Shape_get_origin(self.Shape))
    
    cpdef set_origin(ShapeWrapper self, origin):
        cgraphics.Shape_set_origin(self.Shape, system.Vector2f_cast(origin))
    
    cpdef set_origin_struct(ShapeWrapper self, csystem.Vector2f origin):
        cgraphics.Shape_set_origin(self.Shape, origin)
    
    cpdef set_origin_xy(ShapeWrapper self, float x, float y):
        cgraphics.Shape_set_origin(self.Shape, system.Vector2f(x, y))
    
    property origin:
        def __get__(ShapeWrapper self):
            return system.Vector2f_unpack(cgraphics.Shape_get_origin(self.Shape))
        
        def __set__(ShapeWrapper self, origin):
            cgraphics.Shape_set_origin(self.Shape, system.Vector2f_cast(origin))
    
    # transform
    
    cpdef Transform get_transform(ShapeWrapper self):
        cdef cgraphics.Transform transform = cgraphics.Shape_get_transform(self.Shape)
        return Transform_wrap_ptr(&transform)
    
    property transform:
        def __get__(ShapeWrapper self):
            self.get_transform()
    
    # inverse_transform
    
    cpdef Transform get_inverse_transform(ShapeWrapper self):
        cdef cgraphics.Transform transform = cgraphics.Shape_get_inverse_transform(self.Shape)
        return Transform_wrap_ptr(&transform)
    
    property inverse_transform:
        def __get__(ShapeWrapper self):
            self.get_inverse_transform()
    
    # texture
    
    cpdef TextureWrapper get_texture(ShapeWrapper self):
        return Texture_wrap_ptr(cgraphics.Shape_get_texture(self.Shape))
    
    cpdef set_texture(ShapeWrapper self, TextureWrapper texture, bint reset_rect=False):
        cgraphics.Shape_set_texture(self.Shape, texture.Texture, reset_rect)
    
    property texture:
        def __get__(ShapeWrapper self):
            return Texture_wrap_ptr(cgraphics.Shape_get_texture(self.Shape))
        
        def __set__(ShapeWrapper self, TextureWrapper texture):
            cgraphics.Shape_set_texture(self.Shape, texture.Texture, False)
    
    # fill_color
    
    cpdef tuple get_fill_color(ShapeWrapper self):
        return Color_unpack_rgba(cgraphics.Shape_get_fill_color(self.Shape))
    
    cpdef cgraphics.Color get_fill_color_struct(ShapeWrapper self):
        return cgraphics.Shape_get_fill_color(self.Shape)
    
    cpdef tuple get_fill_color_rgb(ShapeWrapper self):
        return Color_unpack_rgb(cgraphics.Shape_get_fill_color(self.Shape))
    
    cpdef tuple get_fill_color_rgba(ShapeWrapper self):
        return Color_unpack_rgba(cgraphics.Shape_get_fill_color(self.Shape))
    
    cpdef set_fill_color(ShapeWrapper self, fill_color):
        cgraphics.Shape_set_fill_color(self.Shape, Color_cast(fill_color))
    
    cpdef set_fill_color_struct(ShapeWrapper self, cgraphics.Color fill_color):
        cgraphics.Shape_set_fill_color(self.Shape, fill_color)
    
    cpdef set_fill_color_rgb(ShapeWrapper self, Uint8 r, Uint8 g, Uint8 b):
        cgraphics.Shape_set_fill_color(self.Shape, Color_from_rgb(r, g, b))
    
    cpdef set_fill_color_rgba(ShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        cgraphics.Shape_set_fill_color(self.Shape, Color_from_rgba(r, g, b, a))
    
    property fill_color:
        def __get__(ShapeWrapper self):
            return Color_unpack_rgba(cgraphics.Shape_get_fill_color(self.Shape))
        
        def __set__(ShapeWrapper self, fill_color):
            cgraphics.Shape_set_fill_color(self.Shape, Color_cast(fill_color))
    
    # outline_color
    
    cpdef cgraphics.Color get_outline_color(ShapeWrapper self):
        return Color_unpack_rgba(cgraphics.Shape_get_outline_color(self.Shape))
    
    cpdef cgraphics.Color get_outline_color_struct(ShapeWrapper self):
        return cgraphics.Shape_get_outline_color(self.Shape)
    
    cpdef tuple get_outline_color_rgb(ShapeWrapper self):
        return Color_unpack_rgb(cgraphics.Shape_get_outline_color(self.Shape))
    
    cpdef tuple get_outline_color_rgba(ShapeWrapper self):
        return Color_unpack_rgba(cgraphics.Shape_get_outline_color(self.Shape))
    
    cpdef set_outline_color(ShapeWrapper self, outline_color):
        cgraphics.Shape_set_outline_color(self.Shape, Color_cast(outline_color))
    
    cpdef set_outline_color_struct(ShapeWrapper self, cgraphics.Color outline_color):
        cgraphics.Shape_set_outline_color(self.Shape, outline_color)
    
    cpdef set_outline_color_rgb(ShapeWrapper self, Uint8 r, Uint8 g, Uint8 b):
        cgraphics.Shape_set_outline_color(self.Shape, Color_from_rgb(r, g, b))
    
    cpdef set_outline_color_rgba(ShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        cgraphics.Shape_set_outline_color(self.Shape, Color_from_rgba(r, g, b, a))
    
    property outline_color:
        def __get__(ShapeWrapper self):
            return Color_unpack_rgba(cgraphics.Shape_get_outline_color(self.Shape))
        
        def __set__(ShapeWrapper self, outline_color):
            cgraphics.Shape_set_outline_color(self.Shape, Color_cast(outline_color))
    
    # outline_thickness
    
    cpdef float get_outline_thickness(ShapeWrapper self):
        return cgraphics.Shape_get_outline_thickness(self.Shape)
    
    cpdef set_outline_thickness(ShapeWrapper self, float thickness):
        cgraphics.Shape_set_outline_thickness(self.Shape, thickness)
    
    property outline_thickness:
        def __get__(ShapeWrapper self):
            return cgraphics.Shape_get_outline_thickness(self.Shape)
        
        def __set__(ShapeWrapper self, float thickness):
            cgraphics.Shape_set_outline_thickness(self.Shape, thickness)
    
    # texture_rect
    
    cpdef tuple get_texture_rect(ShapeWrapper self):
        return IntRect_unpack(cgraphics.Shape_get_texture_rect(self.Shape))
    
    cpdef cgraphics.IntRect get_texture_rect_struct(ShapeWrapper self):
        return cgraphics.Shape_get_texture_rect(self.Shape)
    
    cpdef tuple get_texture_rect_ltwh(ShapeWrapper self):
        return IntRect_unpack(cgraphics.Shape_get_texture_rect(self.Shape))
    
    cpdef set_texture_rect(ShapeWrapper self, rect):
        cgraphics.Shape_set_texture_rect(self.Shape, IntRect_cast(rect))
    
    cpdef set_texture_rect_struct(ShapeWrapper self, cgraphics.IntRect rect):
        cgraphics.Shape_set_texture_rect(self.Shape, rect)
    
    cpdef set_texture_rect_ltwh(ShapeWrapper self, int left, int top, int width, int height):
        cgraphics.Shape_set_texture_rect(self.Shape, IntRect(left, top, width, height))
    
    property texture_rect:
        def __get__(ShapeWrapper self):
            return IntRect_unpack(cgraphics.Shape_get_texture_rect(self.Shape))
        
        def __set__(ShapeWrapper self, rect):
            cgraphics.Shape_set_texture_rect(self.Shape, IntRect_cast(rect))
    
    # point_count
    
    cpdef unsigned int get_point_count(ShapeWrapper self):
        return cgraphics.Shape_get_point_count(self.Shape)
    
    property point_count:
        def __get__(ShapeWrapper self):
            return cgraphics.Shape_get_point_count(self.Shape)
    
    # local_bounds
    
    cpdef tuple get_local_bounds(ShapeWrapper self):
        return FloatRect_unpack(cgraphics.Shape_get_local_bounds(self.Shape))
    
    cpdef cgraphics.FloatRect get_local_bounds_struct(ShapeWrapper self):
        return cgraphics.Shape_get_local_bounds(self.Shape)
    
    cpdef tuple get_local_bounds_ltwh(ShapeWrapper self):
        return FloatRect_unpack(cgraphics.Shape_get_local_bounds(self.Shape))
    
    property local_bounds:
        def __get__(ShapeWrapper self):
            return FloatRect_unpack(cgraphics.Shape_get_local_bounds(self.Shape))
    
    # global_bounds
    
    cpdef tuple get_global_bounds(ShapeWrapper self):
        return FloatRect_unpack(cgraphics.Shape_get_global_bounds(self.Shape))
    
    cpdef cgraphics.FloatRect get_global_bounds_struct(ShapeWrapper self):
        return cgraphics.Shape_get_global_bounds(self.Shape)
    
    cpdef tuple get_global_bounds_ltwh(ShapeWrapper self):
        return FloatRect_unpack(cgraphics.Shape_get_global_bounds(self.Shape))
    
    property global_bounds:
        def __get__(ShapeWrapper self):
            return FloatRect_unpack(cgraphics.Shape_get_global_bounds(self.Shape))
    
    # Cython methods
    
    # move
    
    cpdef move(ShapeWrapper self, offset):
        cgraphics.Shape_move(self.Shape, system.Vector2f_cast(offset))
    
    cpdef move_struct(ShapeWrapper self, csystem.Vector2f offset):
        cgraphics.Shape_move(self.Shape, offset)
    
    cpdef move_xy(ShapeWrapper self, float x, float y):
        cgraphics.Shape_move(self.Shape, system.Vector2f(x, y))
    
    # rotate
    
    cpdef rotate(ShapeWrapper self, float angle):
        cgraphics.Shape_rotate(self.Shape, angle)
    
    # scale_relative
    
    cpdef scale_relative(ShapeWrapper self, scale):
        cgraphics.Shape_scale(self.Shape, system.Vector2f_cast(scale))
    
    cpdef scale_relative_struct(ShapeWrapper self, csystem.Vector2f scale):
        cgraphics.Shape_scale(self.Shape, scale)
    
    cpdef scale_relative_xy(ShapeWrapper self, float x, float y):
        cgraphics.Shape_scale(self.Shape, system.Vector2f(x, y))
    
    # get_point
    
    cpdef tuple get_point(ShapeWrapper self, unsigned int index):
        return system.Vector2f_unpack(cgraphics.Shape_get_point(self.Shape, index))
    
    cpdef csystem.Vector2f get_point_struct(ShapeWrapper self, unsigned int index):
        return cgraphics.Shape_get_point(self.Shape, index)
    
    cpdef tuple get_point_xy(ShapeWrapper self, unsigned int index):
        return system.Vector2f_unpack(cgraphics.Shape_get_point(self.Shape, index))
    
    cpdef update(ShapeWrapper self):
        cgraphics.Shape_update(self.Shape)
    
    cpdef destroy(ShapeWrapper self):
        if self.Shape:
            cgraphics.Shape_destroy(self.Shape)
            self.Shape = NULL
    
    # draw
    
    cpdef draw(ShapeWrapper self, RenderWindowWrapper render_window):
        cgraphics.RenderWindow_draw_shape(render_window.RenderWindow, self.Shape, RENDER_STATES_DEFAULT_PTR)
    
    cdef draw_transform_struct(ShapeWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform):
        cdef cgraphics.RenderStates render_states
        render_states.blend_mode = cgraphics.BLEND_ALPHA
        render_states.transform = transform
        render_states.texture = NULL
        render_states.shader = NULL
        
        cgraphics.RenderWindow_draw_shape(
            render_window.RenderWindow,
            self.Shape,
            &render_states,
        )


#cdef class Shape(ShapeWrapper):
    #def __cinit__(Shape self):
        #self.Shape = cgraphics.Shape_create(NULL, NULL, NULL)


#cdef ShapeWrapper Shape_create():
    #return Shape_wrap_ptr(cgraphics.Shape_create(NULL, NULL, NULL))


cdef ShapeWrapper Shape_wrap_ptr(cgraphics.Shape* shape_ptr):
    cdef ShapeWrapper shape = ShapeWrapper()
    shape.Shape = shape_ptr
    return shape



# CircleShape
################################################################################

cpdef CircleShapeWrapper CircleShape_create():
    return CircleShape_wrap_ptr(cgraphics.CircleShape_create())

cdef CircleShapeWrapper CircleShape_wrap_ptr(cgraphics.CircleShape* circle_shape_ptr):
    cdef CircleShapeWrapper circle_shape = CircleShapeWrapper()
    circle_shape.CircleShape = circle_shape_ptr
    return circle_shape


cdef class CircleShapeWrapper(Drawable):
    
    # Special methods
    
    def __dealloc__(CircleShapeWrapper self):
        if self.CircleShape:
            cgraphics.CircleShape_destroy(self.CircleShape)
    
    # Attributes
    
    # position
    
    cpdef tuple get_position(CircleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.CircleShape_get_position(self.CircleShape))
    
    cpdef csystem.Vector2f get_position_struct(CircleShapeWrapper self):
        return cgraphics.CircleShape_get_position(self.CircleShape)
    
    cpdef tuple get_position_xy(CircleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.CircleShape_get_position(self.CircleShape))
    
    cpdef set_position(CircleShapeWrapper self, position):
        cgraphics.CircleShape_set_position(self.CircleShape, system.Vector2f_cast(position))
    
    cpdef set_position_struct(CircleShapeWrapper self, csystem.Vector2f position):
        cgraphics.CircleShape_set_position(self.CircleShape, position)
    
    cpdef set_position_xy(CircleShapeWrapper self, float x, float y):
        cgraphics.CircleShape_set_position(self.CircleShape, system.Vector2f(x, y))
    
    property position:
        def __get__(CircleShapeWrapper self):
            return system.Vector2f_unpack(cgraphics.CircleShape_get_position(self.CircleShape))
        
        def __set__(CircleShapeWrapper self, position):
            cgraphics.CircleShape_set_position(self.CircleShape, system.Vector2f_cast(position))
    
    # rotation
    
    cpdef float get_rotation(CircleShapeWrapper self):
        return cgraphics.CircleShape_get_rotation(self.CircleShape)
    
    cpdef set_rotation(CircleShapeWrapper self, float angle):
        cgraphics.CircleShape_set_rotation(self.CircleShape, angle)
    
    property rotation:
        def __get__(CircleShapeWrapper self):
            return cgraphics.CircleShape_get_rotation(self.CircleShape)
        
        def __set__(CircleShapeWrapper self, float angle):
            cgraphics.CircleShape_set_rotation(self.CircleShape, angle)
    
    # scale
    
    cpdef tuple get_scale(CircleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.CircleShape_get_scale(self.CircleShape))
    
    cpdef csystem.Vector2f get_scale_struct(CircleShapeWrapper self):
        return cgraphics.CircleShape_get_scale(self.CircleShape)
    
    cpdef tuple get_scale_xy(CircleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.CircleShape_get_scale(self.CircleShape))
    
    cpdef set_scale(CircleShapeWrapper self, scale):
        cgraphics.CircleShape_set_scale(self.CircleShape, system.Vector2f_cast(scale))
    
    cpdef set_scale_struct(CircleShapeWrapper self, csystem.Vector2f scale):
        cgraphics.CircleShape_set_scale(self.CircleShape, scale)
    
    cpdef set_scale_xy(CircleShapeWrapper self, float x, float y):
        cgraphics.CircleShape_set_scale(self.CircleShape, system.Vector2f(x, y))
    
    property scale:
        def __get__(CircleShapeWrapper self):
            return system.Vector2f_unpack(cgraphics.CircleShape_get_scale(self.CircleShape))
        
        def __set__(CircleShapeWrapper self, scale):
            cgraphics.CircleShape_set_scale(self.CircleShape, system.Vector2f_cast(scale))
    
    # origin
    
    cpdef tuple get_origin(CircleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.CircleShape_get_origin(self.CircleShape))
    
    cpdef csystem.Vector2f get_origin_struct(CircleShapeWrapper self):
        return cgraphics.CircleShape_get_origin(self.CircleShape)
    
    cpdef tuple get_origin_xy(CircleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.CircleShape_get_origin(self.CircleShape))
    
    cpdef set_origin(CircleShapeWrapper self, origin):
        cgraphics.CircleShape_set_origin(self.CircleShape, system.Vector2f_cast(origin))
    
    cpdef set_origin_struct(CircleShapeWrapper self, csystem.Vector2f origin):
        cgraphics.CircleShape_set_origin(self.CircleShape, origin)
    
    cpdef set_origin_xy(CircleShapeWrapper self, float x, float y):
        cgraphics.CircleShape_set_origin(self.CircleShape, system.Vector2f(x, y))
    
    property origin:
        def __get__(CircleShapeWrapper self):
            return system.Vector2f_unpack(cgraphics.CircleShape_get_origin(self.CircleShape))
        
        def __set__(CircleShapeWrapper self, origin):
            cgraphics.CircleShape_set_origin(self.CircleShape, system.Vector2f_cast(origin))
    
    # transform
    
    cpdef Transform get_transform(CircleShapeWrapper self):
        cdef cgraphics.Transform transform = cgraphics.CircleShape_get_transform(self.CircleShape)
        return Transform_wrap_ptr(&transform)
    
    cpdef Transform get_inverse_transform(CircleShapeWrapper self):
        cdef cgraphics.Transform transform = cgraphics.CircleShape_get_inverse_transform(self.CircleShape)
        return Transform_wrap_ptr(&transform)
    
    # fill_color
    
    cpdef tuple get_fill_color(CircleShapeWrapper self):
        return Color_unpack_rgba(cgraphics.CircleShape_get_fill_color(self.CircleShape))
    
    cpdef cgraphics.Color get_fill_color_struct(CircleShapeWrapper self):
        return cgraphics.CircleShape_get_fill_color(self.CircleShape)
    
    cpdef tuple get_fill_color_rgb(CircleShapeWrapper self):
        return Color_unpack_rgb(cgraphics.CircleShape_get_fill_color(self.CircleShape))
    
    cpdef tuple get_fill_color_rgba(CircleShapeWrapper self):
        return Color_unpack_rgba(cgraphics.CircleShape_get_fill_color(self.CircleShape))
    
    cpdef set_fill_color(CircleShapeWrapper self, fill_color):
        cgraphics.CircleShape_set_fill_color(self.CircleShape, Color_cast(fill_color))
    
    cpdef set_fill_color_struct(CircleShapeWrapper self, cgraphics.Color fill_color):
        cgraphics.CircleShape_set_fill_color(self.CircleShape, fill_color)
    
    cpdef set_fill_color_rgb(CircleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b):
        cgraphics.CircleShape_set_fill_color(self.CircleShape, Color_from_rgb(r, g, b))
    
    cpdef set_fill_color_rgba(CircleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        cgraphics.CircleShape_set_fill_color(self.CircleShape, Color_from_rgba(r, g, b, a))
    
    property fill_color:
        def __get__(CircleShapeWrapper self):
            return Color_unpack_rgba(cgraphics.CircleShape_get_fill_color(self.CircleShape))
        
        def __set__(CircleShapeWrapper self, fill_color):
            cgraphics.CircleShape_set_fill_color(self.CircleShape, Color_cast(fill_color))
    
    # outline_color
    
    cpdef tuple get_outline_color(CircleShapeWrapper self):
        return Color_unpack_rgba(cgraphics.CircleShape_get_outline_color(self.CircleShape))
    
    cpdef cgraphics.Color get_outline_color_struct(CircleShapeWrapper self):
        return cgraphics.CircleShape_get_outline_color(self.CircleShape)
    
    cpdef tuple get_outline_color_rgb(CircleShapeWrapper self):
        return Color_unpack_rgb(cgraphics.CircleShape_get_outline_color(self.CircleShape))
    
    cpdef tuple get_outline_color_rgba(CircleShapeWrapper self):
        return Color_unpack_rgba(cgraphics.CircleShape_get_outline_color(self.CircleShape))
    
    cpdef set_outline_color(CircleShapeWrapper self, outline_color):
        cgraphics.CircleShape_set_outline_color(self.CircleShape, Color_cast(outline_color))
    
    cpdef set_outline_color_struct(CircleShapeWrapper self, cgraphics.Color outline_color):
        cgraphics.CircleShape_set_outline_color(self.CircleShape, outline_color)
    
    cpdef set_outline_color_rgb(CircleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b):
        cgraphics.CircleShape_set_outline_color(self.CircleShape, Color_from_rgb(r, g, b))
    
    cpdef set_outline_color_rgba(CircleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        cgraphics.CircleShape_set_outline_color(self.CircleShape, Color_from_rgba(r, g, b, a))
    
    property outline_color:
        def __get__(CircleShapeWrapper self):
            return Color_unpack_rgba(cgraphics.CircleShape_get_outline_color(self.CircleShape))
        
        def __set__(CircleShapeWrapper self, outline_color):
            cgraphics.CircleShape_set_outline_color(self.CircleShape, Color_cast(outline_color))
    
    # outline_thickness
    
    cpdef float get_outline_thickness(CircleShapeWrapper self):
        return cgraphics.CircleShape_get_outline_thickness(self.CircleShape)
    
    cpdef set_outline_thickness(CircleShapeWrapper self, float thickness):
        cgraphics.CircleShape_set_outline_thickness(self.CircleShape, thickness)
    
    property outline_thickness:
        def __get__(CircleShapeWrapper self):
            return cgraphics.CircleShape_get_outline_thickness(self.CircleShape)
        
        def __set__(CircleShapeWrapper self, float thickness):
            cgraphics.CircleShape_set_outline_thickness(self.CircleShape, thickness)
    
    # texture
    
    cpdef TextureWrapper get_texture(CircleShapeWrapper self):
        return Texture_wrap_ptr(cgraphics.CircleShape_get_texture(self.CircleShape))
    
    cpdef set_texture(CircleShapeWrapper self, TextureWrapper texture, bint reset_rect=False):
        cgraphics.CircleShape_set_texture(self.CircleShape, texture.Texture, reset_rect)
    
    property texture:
        def __get__(CircleShapeWrapper self):
            return Texture_wrap_ptr(cgraphics.CircleShape_get_texture(self.CircleShape))
        
        def __set__(CircleShapeWrapper self, TextureWrapper texture):
            cgraphics.CircleShape_set_texture(self.CircleShape, texture.Texture, False)
    
    # texture_rect
    
    cpdef tuple get_texture_rect(CircleShapeWrapper self):
        return IntRect_unpack(cgraphics.CircleShape_get_texture_rect(self.CircleShape))
    
    cpdef cgraphics.IntRect get_texture_rect_struct(CircleShapeWrapper self):
        return cgraphics.CircleShape_get_texture_rect(self.CircleShape)
    
    cpdef tuple get_texture_rect_ltwh(CircleShapeWrapper self):
        return IntRect_unpack(cgraphics.CircleShape_get_texture_rect(self.CircleShape))
    
    cpdef set_texture_rect(CircleShapeWrapper self, rect):
        cgraphics.CircleShape_set_texture_rect(self.CircleShape, IntRect_cast(rect))
    
    cpdef set_texture_rect_struct(CircleShapeWrapper self, cgraphics.IntRect rect):
        cgraphics.CircleShape_set_texture_rect(self.CircleShape, rect)
    
    cpdef set_texture_rect_ltwh(CircleShapeWrapper self, int left, int top, int width, int height):
        cgraphics.CircleShape_set_texture_rect(self.CircleShape, IntRect(left, top, width, height))
    
    property texture_rect:
        def __get__(CircleShapeWrapper self):
            return IntRect_unpack(cgraphics.CircleShape_get_texture_rect(self.CircleShape))
        
        def __set__(CircleShapeWrapper self, rect):
            cgraphics.CircleShape_set_texture_rect(self.CircleShape, IntRect_cast(rect))
    
    # point_count
    
    cpdef unsigned int get_point_count(CircleShapeWrapper self):
        return cgraphics.CircleShape_get_point_count(self.CircleShape)
    
    cpdef set_point_count(CircleShapeWrapper self, unsigned int count):
        cgraphics.CircleShape_set_point_count(self.CircleShape, count)
    
    property point_count:
        def __get__(CircleShapeWrapper self):
            return cgraphics.CircleShape_get_point_count(self.CircleShape)
        
        def __set__(CircleShapeWrapper self, unsigned int count):
            cgraphics.CircleShape_set_point_count(self.CircleShape, count)
    
    # radius
    
    cpdef float get_radius(CircleShapeWrapper self):
        return cgraphics.CircleShape_get_radius(self.CircleShape)
    
    cpdef set_radius(CircleShapeWrapper self, float radius):
        cgraphics.CircleShape_set_radius(self.CircleShape, radius)
    
    property radius:
        def __get__(CircleShapeWrapper self):
            return cgraphics.CircleShape_get_radius(self.CircleShape)
        
        def __set__(CircleShapeWrapper self, float radius):
            cgraphics.CircleShape_set_radius(self.CircleShape, radius)
    
    # local_bounds
    
    cpdef tuple get_local_bounds(CircleShapeWrapper self):
        return FloatRect_unpack(cgraphics.CircleShape_get_local_bounds(self.CircleShape))
    
    cpdef cgraphics.FloatRect get_local_bounds_struct(CircleShapeWrapper self):
        return cgraphics.CircleShape_get_local_bounds(self.CircleShape)
    
    cpdef tuple get_local_bounds_ltwh(CircleShapeWrapper self):
        return FloatRect_unpack(cgraphics.CircleShape_get_local_bounds(self.CircleShape))
    
    property local_bounds:
        def __get__(CircleShapeWrapper self):
            return FloatRect_unpack(cgraphics.CircleShape_get_local_bounds(self.CircleShape))
    
    # global_bounds
    
    cpdef tuple get_global_bounds(CircleShapeWrapper self):
        return FloatRect_unpack(cgraphics.CircleShape_get_global_bounds(self.CircleShape))
    
    cpdef cgraphics.FloatRect get_global_bounds_struct(CircleShapeWrapper self):
        return cgraphics.CircleShape_get_global_bounds(self.CircleShape)
    
    cpdef tuple get_global_bounds_ltwh(CircleShapeWrapper self):
        return FloatRect_unpack(cgraphics.CircleShape_get_global_bounds(self.CircleShape))
    
    property global_bounds:
        def __get__(CircleShapeWrapper self):
            return FloatRect_unpack(cgraphics.CircleShape_get_global_bounds(self.CircleShape))
    
    # Cython methods
    
    # move
    
    cpdef move(CircleShapeWrapper self, offset):
        cgraphics.CircleShape_move(self.CircleShape, system.Vector2f_cast(offset))
    
    cpdef move_struct(CircleShapeWrapper self, csystem.Vector2f offset):
        cgraphics.CircleShape_move(self.CircleShape, offset)
    
    cpdef move_xy(CircleShapeWrapper self, float x, float y):
        cgraphics.CircleShape_move(self.CircleShape, system.Vector2f(x, y))
    
    # rotate
    
    cpdef rotate(CircleShapeWrapper self, float angle):
        cgraphics.CircleShape_rotate(self.CircleShape, angle)
    
    # get_point
    
    cpdef tuple get_point(CircleShapeWrapper self, unsigned int index):
        return system.Vector2f_unpack(cgraphics.CircleShape_get_point(self.CircleShape, index))
    
    cpdef csystem.Vector2f get_point_struct(CircleShapeWrapper self, unsigned int index):
        return cgraphics.CircleShape_get_point(self.CircleShape, index)
    
    cpdef tuple get_point_xy(CircleShapeWrapper self, unsigned int index):
        return system.Vector2f_unpack(self.get_point(index))
    
    # scale_relative
    
    cpdef scale_relative(CircleShapeWrapper self, scale):
        cgraphics.CircleShape_scale(self.CircleShape, system.Vector2f_cast(scale))
    
    cpdef scale_relative_struct(CircleShapeWrapper self, csystem.Vector2f scale):
        cgraphics.CircleShape_scale(self.CircleShape, scale)
    
    cpdef scale_relative_xy(CircleShapeWrapper self, float x, float y):
        cgraphics.CircleShape_scale(self.CircleShape, system.Vector2f(x, y))
    
    # drawing
    
    cpdef draw(CircleShapeWrapper self, RenderWindowWrapper render_window):
        cgraphics.RenderWindow_draw_circle_shape(render_window.RenderWindow, self.CircleShape, RENDER_STATES_DEFAULT_PTR)
    
    cdef draw_transform_struct(CircleShapeWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform):
        cdef cgraphics.RenderStates render_states
        render_states.blend_mode = cgraphics.BLEND_ALPHA
        render_states.transform = transform
        render_states.texture = NULL
        render_states.shader = NULL
        
        cgraphics.RenderWindow_draw_circle_shape(
            render_window.RenderWindow,
            self.CircleShape,
            &render_states,
        )


cdef class CircleShape(CircleShapeWrapper):
    def __cinit__(CircleShape self):
        self.CircleShape = cgraphics.CircleShape_create()


# ConvexShape
################################################################################

cpdef ConvexShapeWrapper ConvexShape_create():
    return ConvexShape_wrap_ptr(cgraphics.ConvexShape_create())

cdef ConvexShapeWrapper ConvexShape_wrap_ptr(cgraphics.ConvexShape* convex_shape_ptr):
    cdef ConvexShapeWrapper convex_shape = ConvexShapeWrapper()
    convex_shape.ConvexShape = convex_shape_ptr
    return convex_shape


cdef class ConvexShapeWrapper(Drawable):
    
    # Special methods.
    
    def __dealloc__(ConvexShapeWrapper self):
        cgraphics.ConvexShape_destroy(self.ConvexShape)
    
    # Attributes
    
    # position
    
    cpdef tuple get_position(ConvexShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.ConvexShape_get_position(self.ConvexShape))
    
    cpdef csystem.Vector2f get_position_struct(ConvexShapeWrapper self):
        return cgraphics.ConvexShape_get_position(self.ConvexShape)
    
    cpdef tuple get_position_xy(ConvexShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.ConvexShape_get_position(self.ConvexShape))
    
    cpdef set_position(ConvexShapeWrapper self, position):
        cgraphics.ConvexShape_set_position(self.ConvexShape, system.Vector2f_cast(position))
    
    cpdef set_position_struct(ConvexShapeWrapper self, csystem.Vector2f position):
        cgraphics.ConvexShape_set_position(self.ConvexShape, position)
    
    cpdef set_position_xy(ConvexShapeWrapper self, float x, float y):
        cgraphics.ConvexShape_set_position(self.ConvexShape, system.Vector2f(x, y))
    
    # rotation
    
    cpdef float get_rotation(ConvexShapeWrapper self):
        return cgraphics.ConvexShape_get_rotation(self.ConvexShape)
    
    cpdef set_rotation(ConvexShapeWrapper self, float angle):
        cgraphics.ConvexShape_set_rotation(self.ConvexShape, angle)
    
    property rotation:
        def __get__(ConvexShapeWrapper self):
            return cgraphics.ConvexShape_get_rotation(self.ConvexShape)
        
        def __set__(ConvexShapeWrapper self, float angle):
            cgraphics.ConvexShape_set_rotation(self.ConvexShape, angle)
    
    # scale
    
    cpdef tuple get_scale(ConvexShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.ConvexShape_get_scale(self.ConvexShape))
    
    cpdef csystem.Vector2f get_scale_struct(ConvexShapeWrapper self):
        return cgraphics.ConvexShape_get_scale(self.ConvexShape)
    
    cpdef tuple get_scale_xy(ConvexShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.ConvexShape_get_scale(self.ConvexShape))
    
    cpdef set_scale(ConvexShapeWrapper self, scale):
        cgraphics.ConvexShape_set_scale(self.ConvexShape, system.Vector2f_cast(scale))
    
    cpdef set_scale_struct(ConvexShapeWrapper self, csystem.Vector2f scale):
        cgraphics.ConvexShape_set_scale(self.ConvexShape, scale)
    
    cpdef set_scale_xy(ConvexShapeWrapper self, float x, float y):
        cgraphics.ConvexShape_set_scale(self.ConvexShape, system.Vector2f(x, y))
    
    property scale:
        def __get__(ConvexShapeWrapper self):
            return system.Vector2f_unpack(cgraphics.ConvexShape_get_scale(self.ConvexShape))
        
        def __set__(ConvexShapeWrapper self, scale):
            cgraphics.ConvexShape_set_scale(self.ConvexShape, system.Vector2f_cast(scale))
    
    # origin
    
    cpdef tuple get_origin(ConvexShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.ConvexShape_get_origin(self.ConvexShape))
    
    cpdef csystem.Vector2f get_origin_struct(ConvexShapeWrapper self):
        return cgraphics.ConvexShape_get_origin(self.ConvexShape)
    
    cpdef tuple get_origin_xy(ConvexShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.ConvexShape_get_origin(self.ConvexShape))
    
    cpdef set_origin(ConvexShapeWrapper self, origin):
        cgraphics.ConvexShape_set_origin(self.ConvexShape, system.Vector2f_cast(origin))
    
    cpdef set_origin_struct(ConvexShapeWrapper self, csystem.Vector2f origin):
        cgraphics.ConvexShape_set_origin(self.ConvexShape, origin)
    
    cpdef set_origin_xy(ConvexShapeWrapper self, float x, float y):
        cgraphics.ConvexShape_set_origin(self.ConvexShape, system.Vector2f(x, y))
    
    # transform
    
    cpdef Transform get_transform(ConvexShapeWrapper self):
        cdef cgraphics.Transform transform = cgraphics.ConvexShape_get_transform(self.ConvexShape)
        return Transform_wrap_ptr(&transform)
    
    # inverse_transform
    
    cpdef Transform get_inverse_transform(ConvexShapeWrapper self):
        cdef cgraphics.Transform transform = cgraphics.ConvexShape_get_inverse_transform(self.ConvexShape)
        return Transform_wrap_ptr(&transform)
    
    
    # Cython methods
    
    # move
    
    cpdef move(ConvexShapeWrapper self, offset):
        cgraphics.ConvexShape_move(self.ConvexShape, system.Vector2f_cast(offset))
    
    cpdef move_struct(ConvexShapeWrapper self, csystem.Vector2f offset):
        cgraphics.ConvexShape_move(self.ConvexShape, offset)
    
    cpdef move_xy(ConvexShapeWrapper self, float x, float y):
        cgraphics.ConvexShape_move(self.ConvexShape, system.Vector2f(x, y))
    
    # rotate
    
    cpdef rotate(ConvexShapeWrapper self, float angle):
        cgraphics.ConvexShape_rotate(self.ConvexShape, angle)
    
    # scale_relative
    
    cpdef scale_relative(ConvexShapeWrapper self, scale):
        cgraphics.ConvexShape_scale(self.ConvexShape, system.Vector2f_cast(scale))
    
    cpdef scale_relative_struct(ConvexShapeWrapper self, csystem.Vector2f scale):
        cgraphics.ConvexShape_scale(self.ConvexShape, scale)
    
    cpdef scale_relative_xy(ConvexShapeWrapper self, float x, float y):
        cgraphics.ConvexShape_scale(self.ConvexShape, system.Vector2f(x, y))
    
    # fill_color
    
    cpdef tuple get_fill_color(ConvexShapeWrapper self):
        return Color_unpack_rgba(cgraphics.ConvexShape_get_fill_color(self.ConvexShape))
    
    cpdef cgraphics.Color get_fill_color_struct(ConvexShapeWrapper self):
        return cgraphics.ConvexShape_get_fill_color(self.ConvexShape)
    
    cpdef tuple get_fill_color_rgb(ConvexShapeWrapper self):
        return Color_unpack_rgb(cgraphics.ConvexShape_get_fill_color(self.ConvexShape))
    
    cpdef tuple get_fill_color_rgba(ConvexShapeWrapper self):
        return Color_unpack_rgba(cgraphics.ConvexShape_get_fill_color(self.ConvexShape))
    
    cpdef set_fill_color(ConvexShapeWrapper self, fill_color):
        cgraphics.ConvexShape_set_fill_color(self.ConvexShape, Color_cast(fill_color))
    
    cpdef set_fill_color_struct(ConvexShapeWrapper self, cgraphics.Color fill_color):
        cgraphics.ConvexShape_set_fill_color(self.ConvexShape, fill_color)
    
    cpdef set_fill_color_rgb(ConvexShapeWrapper self, Uint8 r, Uint8 g, Uint8 b):
        self.set_fill_color(Color_from_rgb(r, g, b))
    
    cpdef set_fill_color_rgba(ConvexShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        self.set_fill_color(Color_from_rgba(r, g, b, a))
    
    property fill_color:
        def __get__(ConvexShapeWrapper self):
            return Color_unpack_rgba(cgraphics.ConvexShape_get_fill_color(self.ConvexShape))
        
        def __set__(ConvexShapeWrapper self, fill_color):
            cgraphics.ConvexShape_set_fill_color(self.ConvexShape, Color_cast(fill_color))
    
    # outline_color
    
    cpdef tuple get_outline_color(ConvexShapeWrapper self):
        return Color_unpack_rgba(self.get_outline_color())
    
    cpdef cgraphics.Color get_outline_color_struct(ConvexShapeWrapper self):
        return cgraphics.ConvexShape_get_outline_color(self.ConvexShape)
    
    cpdef tuple get_outline_color_rgb(ConvexShapeWrapper self):
        return Color_unpack_rgb(self.get_outline_color())
    
    cpdef tuple get_outline_color_rgba(ConvexShapeWrapper self):
        return Color_unpack_rgba(self.get_outline_color())
    
    cpdef set_outline_color(ConvexShapeWrapper self, outline_color):
        cgraphics.ConvexShape_set_outline_color(self.ConvexShape, Color_cast(outline_color))
    
    cpdef set_outline_color_struct(ConvexShapeWrapper self, cgraphics.Color outline_color):
        cgraphics.ConvexShape_set_outline_color(self.ConvexShape, outline_color)
    
    cpdef set_outline_color_rgb(ConvexShapeWrapper self, Uint8 r, Uint8 g, Uint8 b):
        self.set_outline_color(Color_from_rgb(r, g, b))
    
    cpdef set_outline_color_rgba(ConvexShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        self.set_outline_color(Color_from_rgba(r, g, b, a))
    
    property outline_color:
        def __get__(ConvexShapeWrapper self):
            return Color_unpack_rgba(self.get_outline_color())
        
        def __set__(ConvexShapeWrapper self, outline_color):
            cgraphics.ConvexShape_set_outline_color(self.ConvexShape, Color_cast(outline_color))
    
    # outline_thickness
    
    cpdef float get_outline_thickness(ConvexShapeWrapper self):
        return cgraphics.ConvexShape_get_outline_thickness(self.ConvexShape)
    
    cpdef set_outline_thickness(ConvexShapeWrapper self, float thickness):
        cgraphics.ConvexShape_set_outline_thickness(self.ConvexShape, thickness)
    
    property outline_thickness:
        def __get__(ConvexShapeWrapper self):
            return cgraphics.ConvexShape_get_outline_thickness(self.ConvexShape)
        
        def __set__(ConvexShapeWrapper self, float thickness):
            cgraphics.ConvexShape_set_outline_thickness(self.ConvexShape, thickness)
    
    # texture
    
    cpdef TextureWrapper get_texture(ConvexShapeWrapper self):
        return Texture_wrap_ptr(cgraphics.ConvexShape_get_texture(self.ConvexShape))
    
    cpdef set_texture(ConvexShapeWrapper self, TextureWrapper texture, bint reset_rect=False):
        cgraphics.ConvexShape_set_texture(self.ConvexShape, texture.Texture, reset_rect)
    
    property texture:
        def __get__(ConvexShapeWrapper self):
            return Texture_wrap_ptr(cgraphics.ConvexShape_get_texture(self.ConvexShape))
        
        def __set__(ConvexShapeWrapper self, TextureWrapper texture):
            cgraphics.ConvexShape_set_texture(self.ConvexShape, texture.Texture, False)
    
    # texture_rect
    
    cpdef tuple get_texture_rect(ConvexShapeWrapper self):
        return IntRect_unpack(cgraphics.ConvexShape_get_texture_rect(self.ConvexShape))
    
    cpdef cgraphics.IntRect get_texture_rect_struct(ConvexShapeWrapper self):
        return cgraphics.ConvexShape_get_texture_rect(self.ConvexShape)
    
    cpdef tuple get_texture_rect_ltwh(ConvexShapeWrapper self):
        return IntRect_unpack(cgraphics.ConvexShape_get_texture_rect(self.ConvexShape))
    
    cpdef set_texture_rect(ConvexShapeWrapper self, rect):
        cgraphics.ConvexShape_set_texture_rect(self.ConvexShape, IntRect_cast(rect))
    
    cpdef set_texture_rect_struct(ConvexShapeWrapper self, cgraphics.IntRect rect):
        cgraphics.ConvexShape_set_texture_rect(self.ConvexShape, rect)
    
    cpdef set_texture_rect_ltwh(ConvexShapeWrapper self, int left, int top, int width, int height):
        cgraphics.ConvexShape_set_texture_rect(self.ConvexShape, IntRect(left, top, width, height))
    
    property texture_rect:
        def __get__(ConvexShapeWrapper self):
            return cgraphics.ConvexShape_get_texture_rect(self.ConvexShape)
        
        def __set__(ConvexShapeWrapper self, rect):
            cgraphics.ConvexShape_set_texture_rect(self.ConvexShape, IntRect_cast(rect))
    
    # point_count
    
    cpdef unsigned int get_point_count(ConvexShapeWrapper self):
        return cgraphics.ConvexShape_get_point_count(self.ConvexShape)
    
    cpdef set_point_count(ConvexShapeWrapper self, unsigned int count):
        cgraphics.ConvexShape_set_point_count(self.ConvexShape, count)
    
    property point_count:
        def __get__(ConvexShapeWrapper self):
            return cgraphics.ConvexShape_get_point_count(self.ConvexShape)
        
        def __set__(ConvexShapeWrapper self, unsigned int count):
            cgraphics.ConvexShape_set_point_count(self.ConvexShape, count)
    
    # get_point
    
    cpdef tuple get_point(ConvexShapeWrapper self, unsigned int index):
        return system.Vector2f_unpack(cgraphics.ConvexShape_get_point(self.ConvexShape, index))
    
    cpdef csystem.Vector2f get_point_struct(ConvexShapeWrapper self, unsigned int index):
        return cgraphics.ConvexShape_get_point(self.ConvexShape, index)
    
    cpdef tuple get_point_xy(ConvexShapeWrapper self, unsigned int index):
        return system.Vector2f_unpack(cgraphics.ConvexShape_get_point(self.ConvexShape, index))
    
    # set_point
    
    cpdef set_point(ConvexShapeWrapper self, unsigned int index, point):
        cgraphics.ConvexShape_set_point(self.ConvexShape, index, system.Vector2f_cast(point))
    
    cpdef set_point_struct(ConvexShapeWrapper self, unsigned int index, csystem.Vector2f point):
        cgraphics.ConvexShape_set_point(self.ConvexShape, index, point)
    
    cpdef set_point_xy(ConvexShapeWrapper self, unsigned int index, float x, float y):
        self.set_point(index, system.Vector2f(x, y))
    
    # local_bounds
    
    cpdef tuple get_local_bounds(ConvexShapeWrapper self):
        return FloatRect_unpack(cgraphics.ConvexShape_get_local_bounds(self.ConvexShape))
    
    cpdef cgraphics.FloatRect get_local_bounds_struct(ConvexShapeWrapper self):
        return cgraphics.ConvexShape_get_local_bounds(self.ConvexShape)
    
    cpdef tuple get_local_bounds_ltwh(ConvexShapeWrapper self):
        return FloatRect_unpack(cgraphics.ConvexShape_get_local_bounds(self.ConvexShape))
    
    property local_bounds:
        def __get__(ConvexShapeWrapper self):
            return cgraphics.ConvexShape_get_local_bounds(self.ConvexShape)
    
    # global_bounds
    
    cpdef tuple get_global_bounds(ConvexShapeWrapper self):
        return FloatRect_unpack(cgraphics.ConvexShape_get_global_bounds(self.ConvexShape))
    
    cpdef cgraphics.FloatRect get_global_bounds_struct(ConvexShapeWrapper self):
        return cgraphics.ConvexShape_get_global_bounds(self.ConvexShape)
    
    cpdef tuple get_global_bounds_ltwh(ConvexShapeWrapper self):
        return FloatRect_unpack(cgraphics.ConvexShape_get_global_bounds(self.ConvexShape))
    
    property global_bounds:
        def __get__(ConvexShapeWrapper self):
            return FloatRect_unpack(cgraphics.ConvexShape_get_global_bounds(self.ConvexShape))
    
    # drawing
    
    cpdef draw(ConvexShapeWrapper self, RenderWindowWrapper render_window):
        cgraphics.RenderWindow_draw_convex_shape(render_window.RenderWindow, self.ConvexShape, RENDER_STATES_DEFAULT_PTR)
    
    cdef draw_transform_struct(ConvexShapeWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform):
        cdef cgraphics.RenderStates render_states
        render_states.blend_mode = cgraphics.BLEND_ALPHA
        render_states.transform = transform
        render_states.texture = NULL
        render_states.shader = NULL
        
        cgraphics.RenderWindow_draw_convex_shape(
            render_window.RenderWindow,
            self.ConvexShape,
            &render_states,
        )


cdef class ConvexShape(ConvexShapeWrapper):
    def __cinit__(ConvexShape self):
        self.ConvexShape = cgraphics.ConvexShape_create()


# RectangleShape
################################################################################

cpdef RectangleShapeWrapper RectangleShape_create():
    return RectangleShape_wrap_ptr(cgraphics.RectangleShape_create())

cdef RectangleShapeWrapper RectangleShape_wrap_ptr(cgraphics.RectangleShape* rectangle_shape_ptr):
    cdef RectangleShapeWrapper rectangle_shape = RectangleShapeWrapper()
    rectangle_shape.RectangleShape = rectangle_shape_ptr
    return rectangle_shape


cdef class RectangleShapeWrapper(Drawable):
    
    # Special methods
    
    def __dealloc__(RectangleShapeWrapper self):
        cgraphics.RectangleShape_destroy(self.RectangleShape)
    
    # Attributes
    
    # position
    
    cpdef tuple get_position(RectangleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.RectangleShape_get_position(self.RectangleShape))
    
    cpdef csystem.Vector2f get_position_struct(RectangleShapeWrapper self):
        return cgraphics.RectangleShape_get_position(self.RectangleShape)
    
    cpdef tuple get_position_xy(RectangleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.RectangleShape_get_position(self.RectangleShape))
    
    cpdef set_position(RectangleShapeWrapper self, position):
        cgraphics.RectangleShape_set_position(self.RectangleShape, system.Vector2f_cast(position))
    
    cpdef set_position_struct(RectangleShapeWrapper self, csystem.Vector2f position):
        cgraphics.RectangleShape_set_position(self.RectangleShape, position)
    
    cpdef set_position_xy(RectangleShapeWrapper self, float x, float y):
        cgraphics.RectangleShape_set_position(self.RectangleShape, system.Vector2f(x, y))
    
    # rotation
    
    cpdef float get_rotation(RectangleShapeWrapper self):
        return cgraphics.RectangleShape_get_rotation(self.RectangleShape)
    
    cpdef set_rotation(RectangleShapeWrapper self, float angle):
        cgraphics.RectangleShape_set_rotation(self.RectangleShape, angle)
    
    property rotation:
        def __get__(RectangleShapeWrapper self):
            return cgraphics.RectangleShape_get_rotation(self.RectangleShape)
        
        def __set__(RectangleShapeWrapper self, float angle):
            cgraphics.RectangleShape_set_rotation(self.RectangleShape, angle)
    
    # scale
    
    cpdef tuple get_scale(RectangleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.RectangleShape_get_scale(self.RectangleShape))
    
    cpdef csystem.Vector2f get_scale_struct(RectangleShapeWrapper self):
        return cgraphics.RectangleShape_get_scale(self.RectangleShape)
    
    cpdef tuple get_scale_xy(RectangleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.RectangleShape_get_scale(self.RectangleShape))
    
    cpdef set_scale(RectangleShapeWrapper self, scale):
        cgraphics.RectangleShape_set_scale(self.RectangleShape, system.Vector2f_cast(scale))
    
    cpdef set_scale_struct(RectangleShapeWrapper self, csystem.Vector2f scale):
        cgraphics.RectangleShape_set_scale(self.RectangleShape, scale)
    
    cpdef set_scale_xy(RectangleShapeWrapper self, float x, float y):
        cgraphics.RectangleShape_set_scale(self.RectangleShape, system.Vector2f(x, y))
    
    property scale:
        def __get__(RectangleShapeWrapper self):
            return system.Vector2f_unpack(cgraphics.RectangleShape_get_scale(self.RectangleShape))
        
        def __set__(RectangleShapeWrapper self, scale):
            cgraphics.RectangleShape_set_scale(self.RectangleShape, system.Vector2f_cast(scale))
    
    # origin
    
    cpdef tuple get_origin(RectangleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.RectangleShape_get_origin(self.RectangleShape))
    
    cpdef csystem.Vector2f get_origin_struct(RectangleShapeWrapper self):
        return cgraphics.RectangleShape_get_origin(self.RectangleShape)
    
    cpdef tuple get_origin_xy(RectangleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.RectangleShape_get_origin(self.RectangleShape))
    
    cpdef set_origin(RectangleShapeWrapper self, origin):
        cgraphics.RectangleShape_set_origin(self.RectangleShape, system.Vector2f_cast(origin))
    
    cpdef set_origin_struct(RectangleShapeWrapper self, csystem.Vector2f origin):
        cgraphics.RectangleShape_set_origin(self.RectangleShape, origin)
    
    cpdef set_origin_xy(RectangleShapeWrapper self, float x, float y):
        cgraphics.RectangleShape_set_origin(self.RectangleShape, system.Vector2f(x, y))
    
    property origin:
        def __get__(RectangleShapeWrapper self):
            return system.Vector2f_unpack(cgraphics.RectangleShape_get_origin(self.RectangleShape))
        
        def __set__(RectangleShapeWrapper self, origin):
            cgraphics.RectangleShape_set_origin(self.RectangleShape, system.Vector2f_cast(origin))
    
    # Cython methods
    
    # move
    
    cpdef move(RectangleShapeWrapper self, offset):
        cgraphics.RectangleShape_move(self.RectangleShape, system.Vector2f_cast(offset))
    
    cpdef move_struct(RectangleShapeWrapper self, csystem.Vector2f offset):
        cgraphics.RectangleShape_move(self.RectangleShape, offset)
    
    cpdef move_xy(RectangleShapeWrapper self, float x, float y):
        cgraphics.RectangleShape_move(self.RectangleShape, system.Vector2f(x, y))
    
    # rotate
    
    cpdef rotate(RectangleShapeWrapper self, float angle):
        cgraphics.RectangleShape_rotate(self.RectangleShape, angle)
    
    # scale_relative
    
    cpdef scale_relative(RectangleShapeWrapper self, scale):
        cgraphics.RectangleShape_scale(self.RectangleShape, system.Vector2f_cast(scale))
    
    cpdef scale_relative_struct(RectangleShapeWrapper self, csystem.Vector2f scale):
        cgraphics.RectangleShape_scale(self.RectangleShape, scale)
    
    cpdef scale_relative_xy(RectangleShapeWrapper self, float x, float y):
        cgraphics.RectangleShape_scale(self.RectangleShape, system.Vector2f(x, y))
    
    # transform
    
    cpdef Transform get_transform(RectangleShapeWrapper self):
        cdef cgraphics.Transform transform = cgraphics.RectangleShape_get_transform(self.RectangleShape)
        return Transform_wrap_ptr(&transform)
    
    # inverse_transform
    
    cpdef Transform get_inverse_transform(RectangleShapeWrapper self):
        cdef cgraphics.Transform transform = cgraphics.RectangleShape_get_inverse_transform(self.RectangleShape)
        return Transform_wrap_ptr(&transform)
    
    # fill_color
    
    cpdef tuple get_fill_color(RectangleShapeWrapper self):
        return Color_unpack_rgba(cgraphics.RectangleShape_get_fill_color(self.RectangleShape))
    
    cpdef cgraphics.Color get_fill_color_struct(RectangleShapeWrapper self):
        return cgraphics.RectangleShape_get_fill_color(self.RectangleShape)
    
    cpdef tuple get_fill_color_rgb(RectangleShapeWrapper self):
        return Color_unpack_rgb(cgraphics.RectangleShape_get_fill_color(self.RectangleShape))
    
    cpdef tuple get_fill_color_rgba(RectangleShapeWrapper self):
        return Color_unpack_rgba(cgraphics.RectangleShape_get_fill_color(self.RectangleShape))
    
    cpdef set_fill_color(RectangleShapeWrapper self, fill_color):
        cgraphics.RectangleShape_set_fill_color(self.RectangleShape, Color_cast(fill_color))
    
    cpdef set_fill_color_struct(RectangleShapeWrapper self, cgraphics.Color fill_color):
        cgraphics.RectangleShape_set_fill_color(self.RectangleShape, fill_color)
    
    cpdef set_fill_color_rgb(RectangleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b):
        cgraphics.RectangleShape_set_fill_color(self.RectangleShape, Color_from_rgb(r, g, b))
    
    cpdef set_fill_color_rgba(RectangleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        cgraphics.RectangleShape_set_fill_color(self.RectangleShape, Color_from_rgba(r, g, b, a))
    
    property fill_color:
        def __get__(RectangleShapeWrapper self):
            return Color_unpack_rgba(cgraphics.RectangleShape_get_fill_color(self.RectangleShape))
        
        def __set__(RectangleShapeWrapper self, fill_color):
            cgraphics.RectangleShape_set_fill_color(self.RectangleShape, Color_cast(fill_color))
    
    # outline_color
    
    cpdef tuple get_outline_color(RectangleShapeWrapper self):
        return Color_unpack_rgba(cgraphics.RectangleShape_get_outline_color(self.RectangleShape))
    
    cpdef cgraphics.Color get_outline_color_struct(RectangleShapeWrapper self):
        return cgraphics.RectangleShape_get_outline_color(self.RectangleShape)
    
    cpdef tuple get_outline_color_rgb(RectangleShapeWrapper self):
        return Color_unpack_rgb(cgraphics.RectangleShape_get_outline_color(self.RectangleShape))
    
    cpdef tuple get_outline_color_rgba(RectangleShapeWrapper self):
        return Color_unpack_rgba(cgraphics.RectangleShape_get_outline_color(self.RectangleShape))
    
    cpdef set_outline_color(RectangleShapeWrapper self, outline_color):
        cgraphics.RectangleShape_set_outline_color(self.RectangleShape, Color_cast(outline_color))
    
    cpdef set_outline_color_struct(RectangleShapeWrapper self, cgraphics.Color outline_color):
        cgraphics.RectangleShape_set_outline_color(self.RectangleShape, outline_color)
    
    cpdef set_outline_color_rgb(RectangleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b):
        cgraphics.RectangleShape_set_outline_color(self.RectangleShape, Color_from_rgb(r, g, b))
    
    cpdef set_outline_color_rgba(RectangleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        cgraphics.RectangleShape_set_outline_color(self.RectangleShape, Color_from_rgba(r, g, b, a))
    
    property outline_color:
        def __get__(RectangleShapeWrapper self):
            return Color_unpack_rgba(cgraphics.RectangleShape_get_outline_color(self.RectangleShape))
        
        def __set__(RectangleShapeWrapper self, outline_color):
            cgraphics.RectangleShape_set_outline_color(self.RectangleShape, Color_cast(outline_color))
    
    # outline_thickness
    
    cpdef float get_outline_thickness(RectangleShapeWrapper self):
        return cgraphics.RectangleShape_get_outline_thickness(self.RectangleShape)
    
    cpdef set_outline_thickness(RectangleShapeWrapper self, float thickness):
        cgraphics.RectangleShape_set_outline_thickness(self.RectangleShape, thickness)
    
    property outline_thickness:
        def __get__(RectangleShapeWrapper self):
            return cgraphics.RectangleShape_get_outline_thickness(self.RectangleShape)
        
        def __set__(RectangleShapeWrapper self, float thickness):
            cgraphics.RectangleShape_set_outline_thickness(self.RectangleShape, thickness)
    
    # texture
    
    cpdef TextureWrapper get_texture(RectangleShapeWrapper self):
        return Texture_wrap_ptr(cgraphics.RectangleShape_get_texture(self.RectangleShape))
    
    cpdef set_texture(RectangleShapeWrapper self, TextureWrapper texture, bint reset_rect=False):
        cgraphics.RectangleShape_set_texture(self.RectangleShape, texture.Texture, reset_rect)
    
    property texture:
        def __get__(RectangleShapeWrapper self):
            return Texture_wrap_ptr(cgraphics.RectangleShape_get_texture(self.RectangleShape))
        
        def __set__(RectangleShapeWrapper self, TextureWrapper texture):
            cgraphics.RectangleShape_set_texture(self.RectangleShape, texture.Texture, False)
    
    # texture_rect
    
    cpdef tuple get_texture_rect(RectangleShapeWrapper self):
        return IntRect_unpack(cgraphics.RectangleShape_get_texture_rect(self.RectangleShape))
    
    cpdef cgraphics.IntRect get_texture_rect_struct(RectangleShapeWrapper self):
        return cgraphics.RectangleShape_get_texture_rect(self.RectangleShape)
    
    cpdef tuple get_texture_rect_ltwh(RectangleShapeWrapper self):
        return IntRect_unpack(cgraphics.RectangleShape_get_texture_rect(self.RectangleShape))
    
    cpdef set_texture_rect(RectangleShapeWrapper self, rect):
        cgraphics.RectangleShape_set_texture_rect(self.RectangleShape, IntRect_cast(rect))
    
    cpdef set_texture_rect_struct(RectangleShapeWrapper self, cgraphics.IntRect rect):
        cgraphics.RectangleShape_set_texture_rect(self.RectangleShape, rect)
    
    cpdef set_texture_rect_ltwh(RectangleShapeWrapper self, int left, int top, int width, int height):
        cgraphics.RectangleShape_set_texture_rect(self.RectangleShape, IntRect(left, top, width, height))
    
    property texture_rect:
        def __get__(RectangleShapeWrapper self):
            return IntRect_unpack(cgraphics.RectangleShape_get_texture_rect(self.RectangleShape))
        
        def __set__(RectangleShapeWrapper self, rect):
            cgraphics.RectangleShape_set_texture_rect(self.RectangleShape, IntRect_cast(rect))
    
    # get_point_count
    
    cpdef unsigned int get_point_count(RectangleShapeWrapper self):
        return cgraphics.RectangleShape_get_point_count(self.RectangleShape)
    
    property point_count:
        def __get__(RectangleShapeWrapper self):
            return cgraphics.RectangleShape_get_point_count(self.RectangleShape)
    
    # get_point
    
    cpdef tuple get_point(RectangleShapeWrapper self, unsigned int index):
        return system.Vector2f_unpack(cgraphics.RectangleShape_get_point(self.RectangleShape, index))
    
    cpdef csystem.Vector2f get_point_struct(RectangleShapeWrapper self, unsigned int index):
        return cgraphics.RectangleShape_get_point(self.RectangleShape, index)
    
    cpdef tuple get_point_xy(RectangleShapeWrapper self, unsigned int index):
        return system.Vector2f_unpack(cgraphics.RectangleShape_get_point(self.RectangleShape, index))
    
    # size
    
    cpdef tuple get_size(RectangleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.RectangleShape_get_size(self.RectangleShape))
    
    cpdef csystem.Vector2f get_size_struct(RectangleShapeWrapper self):
        return cgraphics.RectangleShape_get_size(self.RectangleShape)
    
    cpdef tuple get_size_xy(RectangleShapeWrapper self):
        return system.Vector2f_unpack(cgraphics.RectangleShape_get_size(self.RectangleShape))
    
    cpdef set_size(RectangleShapeWrapper self, size):
        cgraphics.RectangleShape_set_size(self.RectangleShape, system.Vector2f_cast(size))
    
    cpdef set_size_struct(RectangleShapeWrapper self, csystem.Vector2f size):
        cgraphics.RectangleShape_set_size(self.RectangleShape, size)
    
    cpdef set_size_xy(RectangleShapeWrapper self, float x, float y):
        cgraphics.RectangleShape_set_size(self.RectangleShape, system.Vector2f(x, y))
    
    property size:
        def __get__(RectangleShapeWrapper self):
            return system.Vector2f_unpack(cgraphics.RectangleShape_get_size(self.RectangleShape))
        
        def __set__(RectangleShapeWrapper self, size):
            cgraphics.RectangleShape_set_size(self.RectangleShape, system.Vector2f_cast(size))
    
    # local_bounds
    
    cpdef tuple get_local_bounds(RectangleShapeWrapper self):
        return FloatRect_unpack(cgraphics.RectangleShape_get_local_bounds(self.RectangleShape))
    
    cpdef cgraphics.FloatRect get_local_bounds_struct(RectangleShapeWrapper self):
        return cgraphics.RectangleShape_get_local_bounds(self.RectangleShape)
    
    cpdef tuple get_local_bounds_ltwh(RectangleShapeWrapper self):
        return FloatRect_unpack(cgraphics.RectangleShape_get_local_bounds(self.RectangleShape))
    
    property local_bounds:
        def __get__(RectangleShapeWrapper self):
            return FloatRect_unpack(cgraphics.RectangleShape_get_local_bounds(self.RectangleShape))
    
    # global_bounds
    
    cpdef tuple get_global_bounds(RectangleShapeWrapper self):
        return FloatRect_unpack(cgraphics.RectangleShape_get_local_bounds(self.RectangleShape))
    
    cpdef cgraphics.FloatRect get_global_bounds_struct(RectangleShapeWrapper self):
        return cgraphics.RectangleShape_get_global_bounds(self.RectangleShape)
    
    cpdef tuple get_global_bounds_ltwh(RectangleShapeWrapper self):
        return FloatRect_unpack(cgraphics.RectangleShape_get_local_bounds(self.RectangleShape))
    
    property global_bounds:
        def __get__(RectangleShapeWrapper self):
            return FloatRect_unpack(cgraphics.RectangleShape_get_local_bounds(self.RectangleShape))
    
    # drawing
    
    cpdef draw(RectangleShapeWrapper self, RenderWindowWrapper render_window):
        cgraphics.RenderWindow_draw_rectangle_shape(render_window.RenderWindow, self.RectangleShape, RENDER_STATES_DEFAULT_PTR)
    
    cdef draw_transform_struct(RectangleShapeWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform):
        cdef cgraphics.RenderStates render_states
        render_states.blend_mode = cgraphics.BLEND_ALPHA
        render_states.transform = transform
        render_states.texture = NULL
        render_states.shader = NULL
        
        cgraphics.RenderWindow_draw_rectangle_shape(
            render_window.RenderWindow,
            self.RectangleShape,
            &render_states,
        )


cdef class RectangleShape(RectangleShapeWrapper):
    def __cinit__(RectangleShape self):
        self.RectangleShape = cgraphics.RectangleShape_create()


# Sprite
################################################################################

cdef SpriteWrapper Sprite_wrap_ptr(cgraphics.Sprite* sprite_ptr):
    cdef SpriteWrapper sprite = SpriteWrapper()
    sprite.Sprite = sprite_ptr
    return sprite


cdef SpriteWrapper Sprite_create():
    return Sprite_wrap_ptr(cgraphics.Sprite_create())


cdef SpriteWrapper Sprite_from_texture(TextureWrapper texture):
    cdef cgraphics.Sprite* sprite_ptr = cgraphics.Sprite_create()
    cgraphics.Sprite_set_texture(sprite_ptr, texture.Texture, False)
    return Sprite_wrap_ptr(sprite_ptr)


cdef SpriteWrapper Sprite_from_file(const char* filename):
    cdef cgraphics.Sprite* sprite_ptr = cgraphics.Sprite_create()
    cgraphics.Sprite_set_texture(sprite_ptr, cgraphics.Texture_create_from_file(filename, NULL), False)
    return Sprite_wrap_ptr(sprite_ptr)


cdef class SpriteWrapper(Drawable):
    # Python constructors
    
    @staticmethod
    def from_texture(TextureWrapper texture):
        return Sprite_from_texture(texture)
    
    @staticmethod
    def from_file(const char* filename):
        return Sprite_from_file(filename)
    
    # Cython methods
    
    cpdef SpriteWrapper copy(SpriteWrapper self):
        return Sprite_wrap_ptr(cgraphics.Sprite_copy(self.Sprite))
    
    cpdef destroy(SpriteWrapper self):
        if self.Sprite:
            cgraphics.Sprite_destroy(self.Sprite)
            self.Sprite = NULL
    
    # Special methods
    
    def __dealloc__(SpriteWrapper self):
        if self.Sprite:
            cgraphics.Sprite_destroy(self.Sprite)
    
    # Attributes
    
    # position
    
    cpdef tuple get_position(SpriteWrapper self):
        return system.Vector2f_unpack(cgraphics.Sprite_get_position(self.Sprite))
    
    cpdef csystem.Vector2f get_position_struct(SpriteWrapper self):
        return cgraphics.Sprite_get_position(self.Sprite)
    
    cpdef tuple get_position_xy(SpriteWrapper self):
        return system.Vector2f_unpack(cgraphics.Sprite_get_position(self.Sprite))
    
    cpdef set_position(SpriteWrapper self, position):
        cgraphics.Sprite_set_position(self.Sprite, system.Vector2f_cast(position))
    
    cpdef set_position_struct(SpriteWrapper self, csystem.Vector2f position):
        cgraphics.Sprite_set_position(self.Sprite, position)
    
    cpdef set_position_xy(SpriteWrapper self, float x, float y):
        cgraphics.Sprite_set_position(self.Sprite, system.Vector2f(x, y))
    
    property position:
        def __get__(SpriteWrapper self):
            return system.Vector2f_unpack(cgraphics.Sprite_get_position(self.Sprite))
        
        def __set__(SpriteWrapper self, position):
            cgraphics.Sprite_set_position(self.Sprite, system.Vector2f_cast(position))

    
    # rotation
    
    cpdef float get_rotation(SpriteWrapper self):
        return cgraphics.Sprite_get_rotation(self.Sprite)
    
    cpdef set_rotation(SpriteWrapper self, float angle):
        cgraphics.Sprite_set_rotation(self.Sprite, angle)
    
    property rotation:
        def __get__(SpriteWrapper self):
            return cgraphics.Sprite_get_rotation(self.Sprite)
        
        def __set__(SpriteWrapper self, float angle):
            cgraphics.Sprite_set_rotation(self.Sprite, angle)
    
    # scale
    
    cpdef tuple get_scale(SpriteWrapper self):
        return system.Vector2f_unpack(cgraphics.Sprite_get_scale(self.Sprite))
    
    cpdef csystem.Vector2f get_scale_struct(SpriteWrapper self):
        return cgraphics.Sprite_get_scale(self.Sprite)
    
    cpdef tuple get_scale_xy(SpriteWrapper self):
        return system.Vector2f_unpack(cgraphics.Sprite_get_scale(self.Sprite))
    
    cpdef set_scale(SpriteWrapper self, scale):
        cgraphics.Sprite_set_scale(self.Sprite, system.Vector2f_cast(scale))
    
    cpdef set_scale_struct(SpriteWrapper self, csystem.Vector2f scale):
        cgraphics.Sprite_set_scale(self.Sprite, scale)
    
    cpdef set_scale_xy(SpriteWrapper self, float x, float y):
        cgraphics.Sprite_set_scale(self.Sprite, system.Vector2f(x, y))
    
    property scale:
        def __get__(SpriteWrapper self):
            return system.Vector2f_unpack(cgraphics.Sprite_get_scale(self.Sprite))
        
        def __set__(SpriteWrapper self, scale):
            cgraphics.Sprite_set_scale(self.Sprite, system.Vector2f_cast(scale))
    
    # origin
    
    cpdef tuple get_origin(SpriteWrapper self):
        return system.Vector2f_unpack(cgraphics.Sprite_get_origin(self.Sprite))
    
    cpdef csystem.Vector2f get_origin_struct(SpriteWrapper self):
        return cgraphics.Sprite_get_origin(self.Sprite)
    
    cpdef tuple get_origin_xy(SpriteWrapper self):
        return system.Vector2f_unpack(cgraphics.Sprite_get_origin(self.Sprite))
    
    cpdef set_origin(SpriteWrapper self, origin):
        cgraphics.Sprite_set_origin(self.Sprite, system.Vector2f_cast(origin))
    
    cpdef set_origin_struct(SpriteWrapper self, csystem.Vector2f origin):
        cgraphics.Sprite_set_origin(self.Sprite, origin)
    
    cpdef set_origin_xy(SpriteWrapper self, float x, float y):
        cgraphics.Sprite_set_origin(self.Sprite, system.Vector2f(x, y))
    
    property origin:
        def __get__(SpriteWrapper self):
            return system.Vector2f_unpack(cgraphics.Sprite_get_origin(self.Sprite))
        
        def __set__(SpriteWrapper self, origin):
            cgraphics.Sprite_set_origin(self.Sprite, system.Vector2f_cast(origin))
    
    # move
    
    cpdef move(SpriteWrapper self, offset):
        cgraphics.Sprite_move(self.Sprite, system.Vector2f_cast(offset))
    
    cpdef move_struct(SpriteWrapper self, csystem.Vector2f offset):
        cgraphics.Sprite_move(self.Sprite, offset)
    
    cpdef move_xy(SpriteWrapper self, float x, float y):
        cgraphics.Sprite_move(self.Sprite, system.Vector2f(x, y))
    
    # rotate
    
    cpdef rotate(SpriteWrapper self, float angle):
        cgraphics.Sprite_rotate(self.Sprite, angle)
    
    # scale_relative
    
    cpdef scale_relative(SpriteWrapper self, factors):
        cgraphics.Sprite_scale(self.Sprite, system.Vector2f_cast(factors))
    
    cpdef scale_relative_struct(SpriteWrapper self, csystem.Vector2f factors):
        cgraphics.Sprite_scale(self.Sprite, factors)
    
    cpdef scale_relative_xy(SpriteWrapper self, float x, float y):
        cgraphics.Sprite_scale(self.Sprite, system.Vector2f(x, y))
    
    # texture
    
    cpdef TextureWrapper get_texture(SpriteWrapper self):
        return Texture_wrap_ptr(cgraphics.Sprite_get_texture(self.Sprite))
    
    cpdef set_texture(SpriteWrapper self, TextureWrapper texture, bint reset_rect=False):
        cgraphics.Sprite_set_texture(self.Sprite, texture.Texture, reset_rect)
    
    property texture:
        def __get__(SpriteWrapper self):
            return Texture_wrap_ptr(cgraphics.Sprite_get_texture(self.Sprite))
    
        def __set__(SpriteWrapper self, TextureWrapper texture):
            cgraphics.Sprite_set_texture(self.Sprite, texture.Texture, False)
    
    # texture_rect
    
    cpdef tuple get_texture_rect(SpriteWrapper self):
        return IntRect_unpack(cgraphics.Sprite_get_texture_rect(self.Sprite))
    
    cpdef cgraphics.IntRect get_texture_rect_struct(SpriteWrapper self):
        return cgraphics.Sprite_get_texture_rect(self.Sprite)
    
    cpdef tuple get_texture_rect_ltwh(SpriteWrapper self):
        return IntRect_unpack(cgraphics.Sprite_get_texture_rect(self.Sprite))
    
    cpdef set_texture_rect(SpriteWrapper self, rect):
        cgraphics.Sprite_set_texture_rect(self.Sprite, IntRect_cast(rect))
    
    cpdef set_texture_rect_struct(SpriteWrapper self, cgraphics.IntRect rect):
        cgraphics.Sprite_set_texture_rect(self.Sprite, rect)
    
    cpdef set_texture_rect_ltwh(SpriteWrapper self, int left, int top, int width, int height):
        cgraphics.Sprite_set_texture_rect(self.Sprite, IntRect(left, top, width, height))
    
    property texture_rect:
        def __get__(SpriteWrapper self):
            return IntRect_unpack(cgraphics.Sprite_get_texture_rect(self.Sprite))
        
        def __set__(SpriteWrapper self, rect):
            cgraphics.Sprite_set_texture_rect(self.Sprite, IntRect_cast(rect))
    
    # transform
    
    cpdef Transform get_transform(SpriteWrapper self):
        cdef cgraphics.Transform transform = cgraphics.Sprite_get_transform(self.Sprite)
        return Transform_wrap_ptr(&transform)
    
    # inverse_transform
    
    cpdef Transform get_inverse_transform(SpriteWrapper self):
        cdef cgraphics.Transform transform = cgraphics.Sprite_get_inverse_transform(self.Sprite)
        return Transform_wrap_ptr(&transform)
    
    # color
    
    cpdef get_color(SpriteWrapper self):
        return Color_unpack_rgba(cgraphics.Sprite_get_color(self.Sprite))
    
    cpdef cgraphics.Color get_color_struct(SpriteWrapper self):
        return cgraphics.Sprite_get_color(self.Sprite)
    
    cpdef tuple get_color_rgb(SpriteWrapper self):
        return Color_unpack_rgb(cgraphics.Sprite_get_color(self.Sprite))
    
    cpdef tuple get_color_rgba(SpriteWrapper self):
        return Color_unpack_rgba(cgraphics.Sprite_get_color(self.Sprite))
    
    cpdef set_color(SpriteWrapper self, color):
        cgraphics.Sprite_set_color(self.Sprite, Color_cast(color))
    
    cpdef set_color_struct(SpriteWrapper self, cgraphics.Color color):
        cgraphics.Sprite_set_color(self.Sprite, color)
    
    cpdef set_color_rgb(SpriteWrapper self, Uint8 r, Uint8 g, Uint8 b):
        cgraphics.Sprite_set_color(self.Sprite, Color_from_rgb(r, g, b))
    
    cpdef set_color_rgba(SpriteWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        cgraphics.Sprite_set_color(self.Sprite, Color_from_rgba(r, g, b, a))
    
    property color:
        def __get__(SpriteWrapper self):
            return Color_unpack_rgba(cgraphics.Sprite_get_color(self.Sprite))
        
        def __set__(SpriteWrapper self, color):
            cgraphics.Sprite_set_color(self.Sprite, Color_cast(color))
    
    # local_bounds
    
    cpdef tuple get_local_bounds(SpriteWrapper self):
        return FloatRect_unpack(cgraphics.Sprite_get_local_bounds(self.Sprite))
    
    cpdef cgraphics.FloatRect get_local_bounds_struct(SpriteWrapper self):
        return cgraphics.Sprite_get_local_bounds(self.Sprite)
    
    cpdef tuple get_local_bounds_ltwh(SpriteWrapper self):
        return FloatRect_unpack(cgraphics.Sprite_get_local_bounds(self.Sprite))
    
    property local_bounds:
        def __get__(SpriteWrapper self):
            return FloatRect_unpack(cgraphics.Sprite_get_local_bounds(self.Sprite))
    
    # global_bounds
    
    cpdef tuple get_global_bounds(SpriteWrapper self):
        return FloatRect_unpack(cgraphics.Sprite_get_local_bounds(self.Sprite))
    
    cpdef cgraphics.FloatRect get_global_bounds_struct(SpriteWrapper self):
        return cgraphics.Sprite_get_global_bounds(self.Sprite)
    
    cpdef tuple get_global_bounds_ltwh(SpriteWrapper self):
        return FloatRect_unpack(cgraphics.Sprite_get_local_bounds(self.Sprite))
    
    property global_bounds:
        def __get__(SpriteWrapper self):
            return FloatRect_unpack(cgraphics.Sprite_get_local_bounds(self.Sprite))
    
    # drawing
    
    cpdef draw(SpriteWrapper self, RenderWindowWrapper render_window):
        cgraphics.RenderWindow_draw_sprite(render_window.RenderWindow, self.Sprite, RENDER_STATES_DEFAULT_PTR)
    
    cdef draw_transform_struct(SpriteWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform):
        cdef cgraphics.RenderStates render_states
        render_states.blend_mode = cgraphics.BLEND_ALPHA
        render_states.transform = transform
        render_states.texture = NULL
        render_states.shader = NULL
        
        cgraphics.RenderWindow_draw_sprite(
            render_window.RenderWindow,
            self.Sprite,
            &render_states,
        )

cdef class Sprite(SpriteWrapper):
    def __cinit__(Sprite self):
        self.Sprite = cgraphics.Sprite_create()


# Font
################################################################################

cdef FontWrapper Font_wrap_ptr(cgraphics.Font* font_ptr):
    cdef FontWrapper font = FontWrapper()
    font.Font = font_ptr
    return font


cdef FontWrapper Font_from_file(const char* filename):
    return Font_wrap_ptr(cgraphics.Font_create_from_file(filename))


cdef FontWrapper Font_from_memory(const void* data, size_t size_in_bytes):
    return Font_wrap_ptr(cgraphics.Font_create_from_memory(data, size_in_bytes))


cdef class FontWrapper:
    
    # Cython methods
    
    cpdef FontWrapper copy(FontWrapper self):
        return Font_wrap_ptr(cgraphics.Font_copy(self.Font))
    
    cpdef destroy(FontWrapper self):
        if self.Font:
            cgraphics.Font_destroy(self.Font)
            self.Font = NULL
    
    cpdef cgraphics.Glyph get_glyph(FontWrapper self, unsigned int code_point, unsigned int character_size, bint bold):
        return cgraphics.Font_get_glyph(self.Font, code_point, character_size, bold)
    
    cpdef int get_kerning(FontWrapper self, unsigned int first, unsigned int second, unsigned int character_size):
        return cgraphics.Font_get_kerning(self.Font, first, second, character_size)
    
    cpdef int get_line_spacing(FontWrapper self, unsigned int character_size):
        return cgraphics.Font_get_line_spacing(self.Font, character_size)
    
    cpdef TextureWrapper get_texture(FontWrapper self, unsigned int character_size):
        return Texture_wrap_ptr(cgraphics.Font_get_texture(self.Font, character_size))
    
    # Special methods
    
    def __dealloc__(FontWrapper self):
        if self.Font:
            cgraphics.Font_destroy(self.Font)


cdef class Font(FontWrapper):
    def __cinit__(FontWrapper self, const char* filename):
        self.Font = cgraphics.Font_create_from_file(filename)


# Text
################################################################################

cdef TextWrapper Text_wrap_ptr(cgraphics.Text* text_ptr):
    cdef TextWrapper text = TextWrapper()
    text.Text = text_ptr
    return text


cdef TextWrapper Text_create():
    return Text_wrap_ptr(cgraphics.Text_create())


cdef class TextWrapper(Drawable):
    
    # Cython methods
    
    cpdef TextWrapper copy(TextWrapper self):
        return Text_wrap_ptr(cgraphics.Text_copy(self.Text))
    
    cpdef destroy(TextWrapper self):
        if self.Text != NULL:
            cgraphics.Text_destroy(self.Text)
            self.Text = NULL
    
    # Attributes
    
    # position
    
    cpdef tuple get_position(TextWrapper self):
        return system.Vector2f_unpack(cgraphics.Text_get_position(self.Text))
    
    cpdef csystem.Vector2f get_position_struct(TextWrapper self):
        return cgraphics.Text_get_position(self.Text)
    
    cpdef tuple get_position_xy(TextWrapper self):
        return system.Vector2f_unpack(cgraphics.Text_get_position(self.Text))
    
    cpdef set_position(TextWrapper self, position):
        cgraphics.Text_set_position(self.Text, system.Vector2f_cast(position))
    
    cpdef set_position_struct(TextWrapper self, csystem.Vector2f position):
        cgraphics.Text_set_position(self.Text, position)
    
    cpdef set_position_xy(TextWrapper self, float x, float y):
        cgraphics.Text_set_position(self.Text, system.Vector2f(x, y))
    
    property position:
        def __get__(TextWrapper self):
            return system.Vector2f_unpack(cgraphics.Text_get_position(self.Text))
        
        def __set__(TextWrapper self, position):
            cgraphics.Text_set_position(self.Text, system.Vector2f_cast(position))
    
    # rotation
    
    cpdef float get_rotation(TextWrapper self):
        return cgraphics.Text_get_rotation(self.Text)
    
    cpdef set_rotation(TextWrapper self, float angle):
        cgraphics.Text_set_rotation(self.Text, angle)
    
    property rotation:
        def __get__(TextWrapper self):
            return cgraphics.Text_get_rotation(self.Text)
        
        def __set__(TextWrapper self, float angle):
            cgraphics.Text_set_rotation(self.Text, angle)
    
    # scale
    
    cpdef tuple get_scale(TextWrapper self):
        return system.Vector2f_unpack(cgraphics.Text_get_scale(self.Text))
    
    cpdef csystem.Vector2f get_scale_struct(TextWrapper self):
        return cgraphics.Text_get_scale(self.Text)
    
    cpdef tuple get_scale_xy(TextWrapper self):
        return system.Vector2f_unpack(cgraphics.Text_get_scale(self.Text))
    
    cpdef set_scale(TextWrapper self, scale):
        cgraphics.Text_set_scale(self.Text, system.Vector2f_cast(scale))
    
    cpdef set_scale_struct(TextWrapper self, csystem.Vector2f scale):
        cgraphics.Text_set_scale(self.Text, scale)
    
    cpdef set_scale_xy(TextWrapper self, float x, float y):
        cgraphics.Text_set_scale(self.Text, system.Vector2f(x, y))
    
    property scale:
        def __get__(TextWrapper self):
            return system.Vector2f_unpack(cgraphics.Text_get_scale(self.Text))
        
        def __set__(TextWrapper self, scale):
            cgraphics.Text_set_scale(self.Text, system.Vector2f_cast(scale))
    
    # origin
    
    cpdef tuple get_origin(TextWrapper self):
        return system.Vector2f_unpack(cgraphics.Text_get_origin(self.Text))
    
    cpdef csystem.Vector2f get_origin_struct(TextWrapper self):
        return cgraphics.Text_get_origin(self.Text)
    
    cpdef tuple get_origin_xy(TextWrapper self):
        return system.Vector2f_unpack(cgraphics.Text_get_origin(self.Text))
    
    cpdef set_origin(TextWrapper self, origin):
        cgraphics.Text_set_origin(self.Text, system.Vector2f_cast(origin))
    
    cpdef set_origin_struct(TextWrapper self, csystem.Vector2f origin):
        cgraphics.Text_set_origin(self.Text, origin)
    
    cpdef set_origin_xy(TextWrapper self, float x, float y):
        cgraphics.Text_set_origin(self.Text, system.Vector2f(x, y))
    
    property origin:
        def __get__(TextWrapper self):
            return system.Vector2f_unpack(cgraphics.Text_get_origin(self.Text))
        
        def __set__(TextWrapper self, origin):
            cgraphics.Text_set_origin(self.Text, system.Vector2f_cast(origin))
    
    # move
    
    cpdef move(TextWrapper self, offset):
        cgraphics.Text_move(self.Text, system.Vector2f_cast(offset))
    
    cpdef move_struct(TextWrapper self, csystem.Vector2f offset):
        cgraphics.Text_move(self.Text, offset)
    
    cpdef move_xy(TextWrapper self, float x, float y):
        cgraphics.Text_move(self.Text, system.Vector2f(x, y))
    
    # rotate
    
    cpdef rotate(TextWrapper self, float angle):
        cgraphics.Text_rotate(self.Text, angle)
    
    # scale_relative
    
    cpdef scale_relative(TextWrapper self, scale):
        cgraphics.Text_scale(self.Text, system.Vector2f_cast(scale))
    
    cpdef scale_relative_struct(TextWrapper self, csystem.Vector2f scale):
        cgraphics.Text_scale(self.Text, scale)
    
    cpdef scale_relative_xy(TextWrapper self, float x, float y):
        cgraphics.Text_scale(self.Text, system.Vector2f(x, y))
    
    # transform
    
    cpdef TransformWrapper get_transform(TextWrapper self):
        cdef cgraphics.Transform transform = cgraphics.Text_get_transform(self.Text)
        return Transform_wrap_ptr(&transform)
    
    # inverse_transform
    
    cpdef TransformWrapper get_inverse_transform(TextWrapper self):
        cdef cgraphics.Transform transform = cgraphics.Text_get_inverse_transform(self.Text)
        return Transform_wrap_ptr(&transform)
    
    # string
    
    cdef char* get_string(TextWrapper self):
        return cgraphics.Text_get_string(self.Text)
    
    cpdef set_string(TextWrapper self, const char* string):
        cgraphics.Text_set_string(self.Text, string)
    
    property string:
        def __get__(TextWrapper self):
            return cgraphics.Text_get_string(self.Text)
        
        def __set__(TextWrapper self, const char* string):
            cgraphics.Text_set_string(self.Text, string)
    
    # TODO: Unicode string
    
    # font
    
    cpdef FontWrapper get_font(TextWrapper self):
        return Font_wrap_ptr(cgraphics.Text_get_font(self.Text))
    
    cpdef set_font(TextWrapper self, FontWrapper font):
        cgraphics.Text_set_font(self.Text, font.Font)
    
    property font:
        def __get__(TextWrapper self):
            return Font_wrap_ptr(cgraphics.Text_get_font(self.Text))
        
        def __set__(TextWrapper self, FontWrapper font):
            cgraphics.Text_set_font(self.Text, font.Font)
    
    # character_size
    
    cpdef unsigned int get_character_size(TextWrapper self):
        return cgraphics.Text_get_character_size(self.Text)
    
    cpdef set_character_size(TextWrapper self, unsigned int size):
        cgraphics.Text_set_character_size(self.Text, size)
    
    property character_size:
        def __get__(TextWrapper self):
            return cgraphics.Text_get_character_size(self.Text)
        
        def __set__(TextWrapper self, unsigned int size):
            cgraphics.Text_set_character_size(self.Text, size)
    
    # style
    
    cpdef unsigned int get_style(TextWrapper self):
        return cgraphics.Text_get_style(self.Text)
    
    cpdef set_style(TextWrapper self, unsigned int style):
        cgraphics.Text_set_style(self.Text, style)
    
    property style:
        def __get__(TextWrapper self):
            return cgraphics.Text_get_style(self.Text)
        
        def __set__(TextWrapper self, unsigned int style):
            cgraphics.Text_set_style(self.Text, style)
    
    # color
    
    cpdef tuple get_color(TextWrapper self):
        return Color_unpack_rgba(cgraphics.Text_get_color(self.Text))
    
    cpdef cgraphics.Color get_color_struct(TextWrapper self):
        return cgraphics.Text_get_color(self.Text)
    
    cpdef tuple get_color_rgb(TextWrapper self):
        return Color_unpack_rgb(cgraphics.Text_get_color(self.Text))
    
    cpdef tuple get_color_rgba(TextWrapper self):
        return Color_unpack_rgba(cgraphics.Text_get_color(self.Text))
    
    cpdef set_color(TextWrapper self, color):
        cgraphics.Text_set_color(self.Text, Color_cast(color))
    
    cpdef set_color_struct(TextWrapper self, cgraphics.Color color):
        cgraphics.Text_set_color(self.Text, color)
    
    cpdef set_color_rgb(TextWrapper self, Uint8 r, Uint8 g, Uint8 b):
        cgraphics.Text_set_color(self.Text, Color_from_rgb(r, g, b))
    
    cpdef set_color_rgba(TextWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        cgraphics.Text_set_color(self.Text, Color_from_rgba(r, g, b, a))
    
    property color:
        def __get__(TextWrapper self):
            return Color_unpack_rgba(cgraphics.Text_get_color(self.Text))
        
        def __set__(TextWrapper self, color):
            cgraphics.Text_set_color(self.Text, Color_cast(color))
    
    # TODO: Unicode string
    
    # find_character_pos
    
    cpdef tuple find_character_pos(TextWrapper self, size_t index):
        return system.Vector2f_unpack(cgraphics.Text_find_character_pos(self.Text, index))
    
    cpdef csystem.Vector2f find_character_pos_struct(TextWrapper self, size_t index):
        return cgraphics.Text_find_character_pos(self.Text, index)
    
    cpdef tuple find_character_pos_xy(TextWrapper self, size_t index):
        return system.Vector2f_unpack(cgraphics.Text_find_character_pos(self.Text, index))
    
    # local_bounds
    
    cpdef tuple get_local_bounds(TextWrapper self):
        return FloatRect_unpack(cgraphics.Text_get_local_bounds(self.Text))
    
    cpdef cgraphics.FloatRect get_local_bounds_struct(TextWrapper self):
        return cgraphics.Text_get_local_bounds(self.Text)
    
    cpdef tuple get_local_bounds_ltwh(TextWrapper self):
        return FloatRect_unpack(cgraphics.Text_get_local_bounds(self.Text))
    
    property local_bounds:
        def __get__(TextWrapper self):
            return FloatRect_unpack(cgraphics.Text_get_local_bounds(self.Text))
    
    # global_bounds
    
    cpdef tuple get_global_bounds(TextWrapper self):
        return FloatRect_unpack(cgraphics.Text_get_global_bounds(self.Text))
    
    cpdef cgraphics.FloatRect get_global_bounds_struct(TextWrapper self):
        return cgraphics.Text_get_global_bounds(self.Text)
    
    cpdef tuple get_global_bounds_ltwh(TextWrapper self):
        return FloatRect_unpack(cgraphics.Text_get_global_bounds(self.Text))
    
    property global_bounds:
        def __get__(TextWrapper self):
            return FloatRect_unpack(cgraphics.Text_get_global_bounds(self.Text))
    
    # drawing
    
    cpdef draw(TextWrapper self, RenderWindowWrapper render_window):
        cgraphics.RenderWindow_draw_text(render_window.RenderWindow, self.Text, RENDER_STATES_DEFAULT_PTR)
    
    cdef draw_transform_struct(TextWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform):
        cdef cgraphics.RenderStates render_states
        render_states.blend_mode = cgraphics.BLEND_ALPHA
        render_states.transform = transform
        render_states.texture = NULL
        render_states.shader = NULL
        
        cgraphics.RenderWindow_draw_text(
            render_window.RenderWindow,
            self.Text,
            &render_states,
        )
    
    # Special methods
    
    def __dealloc__(TextWrapper self):
        if self.Text:
            cgraphics.Text_destroy(self.Text)


cdef class Text(TextWrapper):
    def __cinit__(Text self):
        self.Text = cgraphics.Text_create()


# View
#################################################################################

cdef class ViewWrapper:
    
    # Attributes
    
    # center
    
    cpdef tuple get_center(ViewWrapper self):
        return system.Vector2f_unpack(cgraphics.View_get_center(self.View))
    
    cpdef csystem.Vector2f get_center_struct(ViewWrapper self):
        return cgraphics.View_get_center(self.View)
    
    cpdef tuple get_center_xy(ViewWrapper self):
        return system.Vector2f_unpack(cgraphics.View_get_center(self.View))
    
    cpdef set_center(ViewWrapper self, center):
        cgraphics.View_set_center(self.View, system.Vector2f_cast(center))
    
    cpdef set_center_struct(ViewWrapper self, csystem.Vector2f center):
        cgraphics.View_set_center(self.View, center)
    
    cpdef set_center_xy(ViewWrapper self, float x, float y):
        cgraphics.View_set_center(self.View, system.Vector2f(x, y))
    
    property center:
        def __get__(ViewWrapper self):
            return system.Vector2f_unpack(cgraphics.View_get_center(self.View))
        
        def __set__(ViewWrapper self, center):
            cgraphics.View_set_center(self.View, system.Vector2f_cast(center))
    
    # size
    
    cpdef tuple get_size(ViewWrapper self):
        return system.Vector2f_unpack(cgraphics.View_get_size(self.View))
    
    cpdef csystem.Vector2f get_size_struct(ViewWrapper self):
        return cgraphics.View_get_size(self.View)
    
    cpdef tuple get_size_xy(ViewWrapper self):
        return system.Vector2f_unpack(cgraphics.View_get_size(self.View))
    
    cpdef set_size(ViewWrapper self, size):
        cgraphics.View_set_size(self.View, system.Vector2f_cast(size))
    
    cpdef set_size_struct(ViewWrapper self, csystem.Vector2f size):
        cgraphics.View_set_size(self.View, size)
    
    cpdef set_size_xy(ViewWrapper self, float x, float y):
        cgraphics.View_set_size(self.View, system.Vector2f(x, y))
    
    property size:
        def __get__(ViewWrapper self):
            return system.Vector2f_unpack(cgraphics.View_get_size(self.View))
        
        def __set__(ViewWrapper self, size):
            cgraphics.View_set_size(self.View, system.Vector2f_cast(size))
    
    # rotation
    
    cpdef float get_rotation(ViewWrapper self):
        return cgraphics.View_get_rotation(self.View)
    
    cpdef set_rotation(ViewWrapper self, float angle):
        cgraphics.View_set_rotation(self.View, angle)
    
    property rotation:
        def __get__(ViewWrapper self):
            return cgraphics.View_get_rotation(self.View)
        
        def __set__(ViewWrapper self, float angle):
            cgraphics.View_set_rotation(self.View, angle)
    
    # viewport
    
    cpdef tuple get_viewport(ViewWrapper self):
        return FloatRect_unpack(self.get_viewport())
    
    cpdef cgraphics.FloatRect get_viewport_struct(ViewWrapper self):
        return cgraphics.View_get_viewport(self.View)
    
    cpdef tuple get_viewport_ltwh(ViewWrapper self):
        return FloatRect_unpack(self.get_viewport())
    
    cpdef set_viewport(ViewWrapper self, viewport):
        cgraphics.View_set_viewport(self.View, FloatRect_cast(viewport))
    
    cpdef set_viewport_struct(ViewWrapper self, cgraphics.FloatRect viewport):
        cgraphics.View_set_viewport(self.View, viewport.viewport)
    
    cpdef set_viewport_ltwh(ViewWrapper self, float length, float top, float width, float height):
        cgraphics.View_set_viewport(self.View, FloatRect(length, top, width, height))
    
    property viewport:
        def __get__(ViewWrapper self):
            return FloatRect_unpack(self.get_viewport())
        
        def __set__(ViewWrapper self, viewport):
            cgraphics.View_set_viewport(self.View, FloatRect_cast(viewport))
    
    # Cython methods
    
    # reset
    
    cpdef reset(ViewWrapper self, rectangle):
        cgraphics.View_reset(self.View, FloatRect_cast(rectangle))
    
    cpdef reset_struct(ViewWrapper self, cgraphics.FloatRect rectangle):
        cgraphics.View_reset(self.View, rectangle)
    
    # move
    
    cpdef move(ViewWrapper self, offset):
        cgraphics.View_move(self.View, system.Vector2f_cast(offset))
    
    cpdef move_struct(ViewWrapper self, csystem.Vector2f offset):
        cgraphics.View_move(self.View, offset)
    
    cpdef move_xy(ViewWrapper self, float x, float y):
        cgraphics.View_move(self.View, system.Vector2f(x, y))
    
    # rotate
    
    cpdef rotate(ViewWrapper self, float angle):
        cgraphics.View_rotate(self.View, angle)
    
    # zoom
    
    cpdef zoom(ViewWrapper self, float factor):
        cgraphics.View_zoom(self.View, factor)


cdef class View(ViewWrapper):
    def __cinit__(View self):
        self.View = cgraphics.View_create()


cdef ViewWrapper View_wrap_ptr(cgraphics.View* view_ptr):
    cdef ViewWrapper view = ViewWrapper()
    view.View = view_ptr
    return view


cdef ViewWrapper View_create():
    return View_wrap_ptr(cgraphics.View_create())


cdef ViewWrapper View_from_rect(rect):
    return View_wrap_ptr(cgraphics.View_create_from_rect(FloatRect_cast(rect)))


cdef ViewWrapper View_from_rect_struct(cgraphics.FloatRect rect):
    return View_wrap_ptr(cgraphics.View_create_from_rect(rect))


cdef ViewWrapper View_from_rect_ltwh(float left, float top, float width, float height):
    return View_wrap_ptr(cgraphics.View_create_from_rect(FloatRect(left, top, width, height)))


# Shader
################################################################################

cdef ShaderWrapper Shader_wrap_ptr(cgraphics.Shader* shader_ptr):
    cdef ShaderWrapper shader = ShaderWrapper()
    shader.Shader = shader_ptr
    return shader


cdef ShaderWrapper Shader_from_file(const char* vertex_shader_filename, const char* fragment_shader_filename):
    return Shader_wrap_ptr(cgraphics.Shader_create_from_file(vertex_shader_filename, fragment_shader_filename))


cdef ShaderWrapper Shader_from_memory(const char* vertex_shader, const char* fragment_shader):
    return Shader_wrap_ptr(cgraphics.Shader_create_from_memory(vertex_shader, fragment_shader))


cdef ShaderWrapper Shader_from_stream(system.InputStream vertex_shader, system.InputStream fragment_shader):
    return Shader_wrap_ptr(cgraphics.Shader_create_from_stream(vertex_shader.InputStream, fragment_shader.InputStream))


cdef ShaderWrapper Shader_from_stream_ptr(csystem.InputStream* vertex_shader, csystem.InputStream* fragment_shader):
    return Shader_wrap_ptr(cgraphics.Shader_create_from_stream(vertex_shader, fragment_shader))


cdef bint Shader_is_available():
    return cgraphics.Shader_is_available()


cdef class ShaderWrapper:
    
    # Cython methods
    
    cpdef destroy(ShaderWrapper self):
        if self.Shader:
            cgraphics.Shader_destroy(self.Shader)
            self.Shader = NULL
    
    cpdef set_float_parameter(ShaderWrapper self, const char* name, float x):
        cgraphics.Shader_set_float_parameter(self.Shader, name, x)
    
    cpdef set_float2_parameter(ShaderWrapper self, const char* name, float x, float y):
        cgraphics.Shader_set_float2_parameter(self.Shader, name, x, y)
    
    cpdef set_float3_parameter(ShaderWrapper self, const char* name, float x, float y, float z):
        cgraphics.Shader_set_float3_parameter(self.Shader, name, x, y, z)
    
    cpdef set_float4_parameter(ShaderWrapper self, const char* name, float x, float y, float z, float w):
        cgraphics.Shader_set_float4_parameter(self.Shader, name, x, y, z, w)
    
    cpdef set_vector2_parameter(ShaderWrapper self, const char* name, csystem.Vector2f vector):
        cgraphics.Shader_set_vector2_parameter(self.Shader, name, vector)
    
    cpdef set_vector2_parameter_xy(ShaderWrapper self, const char* name, float x, float y):
        cgraphics.Shader_set_vector2_parameter(self.Shader, name, system.Vector2f(x, y))
    
    cpdef set_vector3_parameter(ShaderWrapper self, const char* name, cgraphics.Vector3f vector):
        cgraphics.Shader_set_vector3_parameter(self.Shader, name, vector)
    
    cpdef set_vector3_parameter_xyz(ShaderWrapper self, const char* name, float x, float y, float z):
        cgraphics.Shader_set_vector3_parameter(self.Shader, name, system.Vector3f(x, y, z))
    
    cpdef set_color_parameter(ShaderWrapper self, const char* name, cgraphics.Color color):
        cgraphics.Shader_set_color_parameter(self.Shader, name, color)
    
    cpdef set_transform_parameter(ShaderWrapper self, const char* name, Transform transform):
        cgraphics.Shader_set_transform_parameter(self.Shader, name, transform.Transform[0])
    
    cdef set_transform_parameter_struct(ShaderWrapper self, const char* name, cgraphics.Transform transform_struct):
        cgraphics.Shader_set_transform_parameter(self.Shader, name, transform_struct)
    
    cpdef set_texture_parameter(ShaderWrapper self, const char* name, Texture texture):
        cgraphics.Shader_set_texture_parameter(self.Shader, name, texture.Texture)
    
    cdef set_texture_parameter_ptr(ShaderWrapper self, const char* name, cgraphics.Texture* texture_ptr):
        cgraphics.Shader_set_texture_parameter(self.Shader, name, texture_ptr)
    
    cpdef set_current_texture_parameter(ShaderWrapper self, const char* name):
        cgraphics.Shader_set_current_texture_parameter(self.Shader, name)
    
    cpdef bind(ShaderWrapper self):
        cgraphics.Shader_bind(self.Shader)
    
    @staticmethod
    def is_available():
        return cgraphics.Shader_is_available()
    
    # Python constructors
    
    @staticmethod
    def from_file(const char* vertex_shader_filename, const char* fragment_shader_filename):
        return Shader_wrap_ptr(cgraphics.Shader_create_from_file(vertex_shader_filename, fragment_shader_filename))
    
    @staticmethod
    def from_memory(const char* vertex_shader, const char* fragment_shader):
        return Shader_wrap_ptr(cgraphics.Shader_create_from_memory(vertex_shader, fragment_shader))
    
    @staticmethod
    def from_stream(system.InputStream vertex_shader, system.InputStream fragment_shader):
        return Shader_wrap_ptr(cgraphics.Shader_create_from_stream(vertex_shader.InputStream, fragment_shader.InputStream))
    
    # Special methods
    
    def __dealloc__(Shader self):
        if self.Shader:
            cgraphics.Shader_destroy(self.Shader)


cdef class Shader(ShaderWrapper):
    def __cinit__(Shader self, const char* vertex_shader_filename, const char* fragment_shader_filename):
        self.Shader = cgraphics.Shader_create_from_file(vertex_shader_filename, fragment_shader_filename)


# RenderStates
################################################################################

cdef class RenderStates:
    
    def __cinit__(RenderStates self):
        cdef cgraphics.RenderStates render_states
        
        render_states.blend_mode = cgraphics.BLEND_ALPHA
        render_states.transform = cgraphics.TRANSFORM_IDENTITY
        #Q: is this required?
        render_states.texture = NULL
        render_states.shader = NULL
        
        self.RenderStates = render_states
    
    # blend_mode
    
    cpdef cgraphics.BlendMode get_blend_mode(RenderStates self):
        return self.RenderStates.blend_mode
    
    cpdef set_blend_mode(RenderStates self, cgraphics.BlendMode blend_mode):
        self.RenderStates.blend_mode = blend_mode
    
    property blend_mode:
        def __get__(RenderStates self):
            return self.RenderStates.blend_mode
        
        def __set__(RenderStates self, cgraphics.BlendMode blend_mode):
            self.RenderStates.blend_mode = blend_mode
    
    # transform
    
    cpdef Transform get_transform(RenderStates self):
        return Transform_wrap_ptr(&self.RenderStates.transform)
    
    cpdef set_transform(RenderStates self, Transform transform):
        self.RenderStates.transform = transform.Transform[0]
    
    property transform:
        def __get__(RenderStates self):
            return Transform_wrap_ptr(&self.RenderStates.transform)
        
        def __set__(RenderStates self, Transform transform):
            self.RenderStates.transform = transform.Transform[0]
    
    # texture
    
    cpdef TextureWrapper get_texture(RenderStates self):
        return Texture_wrap_ptr(self.RenderStates.texture)
    
    cpdef set_texture(RenderStates self, TextureWrapper texture):
        self.RenderStates.texture = texture.Texture
    
    property texture:
        def __get__(RenderStates self):
            return Texture_wrap_ptr(self.RenderStates.texture)
        
        def __set__(RenderStates self, TextureWrapper texture):
            self.RenderStates.texture = texture.Texture
    
    # shader
    
    cpdef Shader get_shader(RenderStates self):
        return Shader_wrap_ptr(self.RenderStates.shader)
    
    cpdef set_shader(RenderStates self, Shader shader):
        self.RenderStates.shader = shader.Shader
    
    property shader:
        def __get__(RenderStates self):
            return Shader_wrap_ptr(self.RenderStates.shader)
        
        def __set__(RenderStates self, Shader shader):
            self.RenderStates.shader = shader.Shader


cdef RenderStates RenderStates_create():
    cdef RenderStates render_states = RenderStates()
    
    render_states.RenderStates.blend_mode = cgraphics.BLEND_ALPHA
    render_states.RenderStates.transform = cgraphics.TRANSFORM_IDENTITY
    #Q: is this required?
    render_states.RenderStates.texture = NULL
    render_states.RenderStates.shader = NULL
    
    return render_states


cdef cgraphics.RenderStates* RenderStates_ptr_from_transform(cgraphics.Transform transform):
    
    cdef cgraphics.RenderStates render_states
    
    render_states.blend_mode = cgraphics.BLEND_ALPHA
    render_states.transform = transform
    # Q: Is this required?
    render_states.texture = NULL
    render_states.shader = NULL
    return &render_states


cdef RenderStates RENDER_STATES_DEFAULT = RenderStates_create()
cdef cgraphics.RenderStates* RENDER_STATES_DEFAULT_PTR = &RENDER_STATES_DEFAULT.RenderStates



# RenderTexture
################################################################################

cdef class RenderTextureWrapper:
    
    # Cython methods
    
    cpdef display(RenderTextureWrapper self):
        cgraphics.RenderTexture_display(self.RenderTexture)
    
    cpdef destroy(RenderTextureWrapper self):
        if self.RenderTexture:
            cgraphics.RenderTexture_destroy(self.RenderTexture)
            self.RenderTexture = NULL
    
    # clear
    
    cpdef clear(RenderTextureWrapper self, color):
        cgraphics.RenderTexture_clear(self.RenderTexture, Color_cast(color))
    
    cpdef clear_struct(RenderTextureWrapper self, cgraphics.Color color):
        cgraphics.RenderTexture_clear(self.RenderTexture, color)
    
    cpdef clear_rgb(RenderTextureWrapper self, Uint8 r, Uint8 g, Uint8 b):
        cgraphics.RenderTexture_clear(self.RenderTexture, Color_from_rgb(r, g, b))
    
    cpdef clear_rgba(RenderTextureWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        cgraphics.RenderTexture_clear(self.RenderTexture, Color_from_rgba(r, g, b, a))
    
    # viewport
    
    cpdef tuple get_viewport(RenderTextureWrapper self, ViewWrapper view):
        return IntRect_unpack(cgraphics.RenderTexture_get_viewport(self.RenderTexture, view.View))
    
    cpdef cgraphics.IntRect get_viewport_struct(RenderTextureWrapper self, ViewWrapper view):
        return cgraphics.RenderTexture_get_viewport(self.RenderTexture, view.View)
    
    cpdef tuple get_viewport_ltwh(RenderTextureWrapper self, ViewWrapper view):
        return IntRect_unpack(cgraphics.RenderTexture_get_viewport(self.RenderTexture, view.View))
    
    # map_pixel_to_coords
    
    cpdef tuple map_pixel_to_coords(RenderTextureWrapper self, point, ViewWrapper view):
        return system.Vector2f_unpack(cgraphics.RenderTexture_map_pixel_to_coords(self.RenderTexture, system.Vector2i_cast(point), view.View))
    
    cpdef csystem.Vector2f map_pixel_to_coords_struct(RenderTextureWrapper self, csystem.Vector2i point, ViewWrapper view):
        return cgraphics.RenderTexture_map_pixel_to_coords(self.RenderTexture, point, view.View)
    
    cpdef tuple map_pixel_to_coords_xy(RenderTextureWrapper self, int x, int y, ViewWrapper view):
        return system.Vector2f_unpack(cgraphics.RenderTexture_map_pixel_to_coords(self.RenderTexture, system.Vector2i(x, y), view.View))
    
    # map_coords_to_pixel
    
    cpdef tuple map_coords_to_pixel(RenderTextureWrapper self, point, ViewWrapper view):
        return system.Vector2i_unpack(cgraphics.RenderTexture_map_coords_to_pixel(self.RenderTexture, system.Vector2f_cast(point), view.View))
    
    cpdef csystem.Vector2i map_coords_to_pixel_struct(RenderTextureWrapper self, csystem.Vector2f point, ViewWrapper view):
        return cgraphics.RenderTexture_map_coords_to_pixel(self.RenderTexture, point, view.View)
    
    cpdef tuple map_coords_to_pixel_xy(RenderTextureWrapper self, float x, float y, ViewWrapper view):
        return system.Vector2i_unpack(cgraphics.RenderTexture_map_coords_to_pixel(self.RenderTexture,system.Vector2f(x, y), view.View))
    
    # draw
    
    cpdef draw_sprite(RenderTextureWrapper self, SpriteWrapper sprite):
        cgraphics.RenderTexture_draw_sprite(self.RenderTexture, sprite.Sprite, RENDER_STATES_DEFAULT_PTR)
    
    cpdef draw_text(RenderTextureWrapper self, TextWrapper text):
        cgraphics.RenderTexture_draw_text(self.RenderTexture, text.Text, RENDER_STATES_DEFAULT_PTR)

    cpdef draw_shape(RenderTextureWrapper self, ShapeWrapper shape):
        cgraphics.RenderTexture_draw_shape(self.RenderTexture, shape.Shape, RENDER_STATES_DEFAULT_PTR)

    cpdef draw_circle_shape(RenderTextureWrapper self, CircleShapeWrapper circle_shape):
        cgraphics.RenderTexture_draw_circle_shape(self.RenderTexture, circle_shape.CircleShape, RENDER_STATES_DEFAULT_PTR)

    cpdef draw_convex_shape(RenderTextureWrapper self, ConvexShapeWrapper convex_shape):
        cgraphics.RenderTexture_draw_convex_shape(self.RenderTexture, convex_shape.ConvexShape, RENDER_STATES_DEFAULT_PTR)

    cpdef draw_rectangle_shape(RenderTextureWrapper self, RectangleShapeWrapper rectangle_shape):
        cgraphics.RenderTexture_draw_rectangle_shape(self.RenderTexture, rectangle_shape.RectangleShape, RENDER_STATES_DEFAULT_PTR)

    cpdef draw_vertex_array(RenderTextureWrapper self, VertexArrayWrapper vertex_array):
        cgraphics.RenderTexture_draw_vertex_array(self.RenderTexture, vertex_array.VertexArray, RENDER_STATES_DEFAULT_PTR)
    
    # TODO: vertices array
    #cpdef draw_primitives(RenderTextureWrapper self, Vertex vertices)
    
    # GL_states
    
    cpdef push_GL_states(RenderTextureWrapper self):
        cgraphics.RenderTexture_push_GL_states(self.RenderTexture)
    
    cpdef pop_GL_states(RenderTextureWrapper self):
        cgraphics.RenderTexture_pop_GL_states(self.RenderTexture)
    
    cpdef reset_GL_states(RenderTextureWrapper self):
        cgraphics.RenderTexture_reset_GL_states(self.RenderTexture)
    
    # Attributes
    
    # size
    
    cpdef tuple get_size(RenderTextureWrapper self):
        return system.Vector2u_unpack(cgraphics.RenderTexture_get_size(self.RenderTexture))
    
    cpdef csystem.Vector2u get_size_struct(RenderTextureWrapper self):
        return cgraphics.RenderTexture_get_size(self.RenderTexture)
    
    cpdef tuple get_size_xy(RenderTextureWrapper self):
        return system.Vector2u_unpack(cgraphics.RenderTexture_get_size(self.RenderTexture))
    
    property size:
        def __get__(RenderTextureWrapper self):
            return system.Vector2u_unpack(cgraphics.RenderTexture_get_size(self.RenderTexture))
    
    # active
    
    cpdef set_active(RenderTextureWrapper self, bint active):
        if not cgraphics.RenderTexture_set_active(self.RenderTexture, active):
            raise ValueError('Failed setting RenderTextureWrapper to be active.')
    
    property active:
        def __set__(RenderTextureWrapper self, bint active):
            self.set_active(active)
    
    # view
    
    cpdef ViewWrapper get_view(RenderTextureWrapper self):
        return View_wrap_ptr(cgraphics.RenderTexture_get_view(self.RenderTexture))
    
    cpdef set_view(RenderTextureWrapper self, ViewWrapper view):
        cgraphics.RenderTexture_set_view(self.RenderTexture, view.View)
    
    property view:
        def __get__(RenderTextureWrapper self):
            return View_wrap_ptr(cgraphics.RenderTexture_get_view(self.RenderTexture))
        
        def __set__(RenderTextureWrapper self, ViewWrapper view):
            cgraphics.RenderTexture_set_view(self.RenderTexture, view.View)
    
    # default_view
    
    cpdef ViewWrapper get_default_view(RenderTextureWrapper self):
        return View_wrap_ptr(cgraphics.RenderTexture_get_default_view(self.RenderTexture))
    
    property default_view:
        def __get__(RenderTextureWrapper self):
            return View_wrap_ptr(cgraphics.RenderTexture_get_default_view(self.RenderTexture))
    
    # texture
    
    cpdef TextureWrapper get_texture(RenderTextureWrapper self):
        return Texture_wrap_ptr(cgraphics.RenderTexture_get_texture(self.RenderTexture))
    
    property texture:
        def __get__(RenderTextureWrapper self):
            return Texture_wrap_ptr(cgraphics.RenderTexture_get_texture(self.RenderTexture))
    
    # smooth
    
    cpdef bint is_smooth(RenderTextureWrapper self):
        return cgraphics.RenderTexture_is_smooth(self.RenderTexture)
    
    cpdef set_smooth(RenderTextureWrapper self, bint smooth):
        cgraphics.RenderTexture_set_smooth(self.RenderTexture, smooth)
    
    property smooth:
        def __get__(RenderTextureWrapper self):
            return cgraphics.RenderTexture_is_smooth(self.RenderTexture)
        
        def __set__(RenderTextureWrapper self, bint smooth):
            cgraphics.RenderTexture_set_smooth(self.RenderTexture, smooth)
    
    # repeated
    
    cpdef bint is_repeated(RenderTextureWrapper self):
        return cgraphics.RenderTexture_is_repeated(self.RenderTexture)
    
    cpdef set_repeated(RenderTextureWrapper self, bint repeated):
        cgraphics.RenderTexture_set_repeated(self.RenderTexture, repeated)
    
    property repeated:
        def __get__(RenderTextureWrapper self):
            return cgraphics.RenderTexture_is_repeated(self.RenderTexture)
        
        def __set__(RenderTextureWrapper self, bint repeated):
            cgraphics.RenderTexture_set_repeated(self.RenderTexture, repeated)
    
    # Special methods
    
    def __dealloc__(RenderTextureWrapper self):
        if self.RenderTexture:
            cgraphics.RenderTexture_destroy(self.RenderTexture)


cdef class RenderTexture(RenderTextureWrapper):
    def __cinit__(RenderTexture self, unsigned int width, unsigned int height, bint depth_buffer):
        self.RenderTexture = cgraphics.RenderTexture_create(width, height, depth_buffer)


cdef RenderTextureWrapper RenderTexture_wrap_ptr(cgraphics.RenderTexture* render_texture_ptr):
    cdef RenderTextureWrapper render_texture = RenderTextureWrapper()
    render_texture.RenderTexture = render_texture_ptr
    return render_texture


cdef RenderTexture RenderTexture_create(unsigned int width, unsigned int height, bint depth_buffer):
    return RenderTexture_wrap_ptr(cgraphics.RenderTexture_create(width, height, depth_buffer))


# RenderWindow
################################################################################

cdef class RenderWindowWrapper:
    
    # Cython methods
    
    cpdef close(RenderWindowWrapper self):
        cgraphics.RenderWindow_close(self.RenderWindow)
    
    cpdef display(RenderWindowWrapper self):
        cgraphics.RenderWindow_display(self.RenderWindow)
    
    cpdef destroy(RenderWindowWrapper self):
        if self.RenderWindow:
            cgraphics.RenderWindow_destroy(self.RenderWindow)
            self.RenderWindow = NULL
    
    # clear
    
    cpdef clear(RenderWindowWrapper self, color):
        cgraphics.RenderWindow_clear(self.RenderWindow, Color_cast(color))
    
    cpdef clear_struct(RenderWindowWrapper self, cgraphics.Color color):
        cgraphics.RenderWindow_clear(self.RenderWindow, color)
    
    cpdef clear_rgb(RenderWindowWrapper self, Uint8 r, Uint8 g, Uint8 b):
        cgraphics.RenderWindow_clear(self.RenderWindow, Color_from_rgb(r, g, b))
    
    cpdef clear_rgba(RenderWindowWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a):
        cgraphics.RenderWindow_clear(self.RenderWindow, Color_from_rgba(r, g, b, a))
    
    # get_viewport
    
    cpdef tuple get_viewport(RenderWindowWrapper self, ViewWrapper view):
        return IntRect_unpack(cgraphics.RenderWindow_get_viewport(self.RenderWindow, view.View))
    
    cpdef cgraphics.IntRect get_viewport_struct(RenderWindowWrapper self, ViewWrapper view):
        return cgraphics.RenderWindow_get_viewport(self.RenderWindow, view.View)
    
    cpdef tuple get_viewport_ltwh(RenderWindowWrapper self, ViewWrapper view):
        return IntRect_unpack(cgraphics.RenderWindow_get_viewport(self.RenderWindow, view.View))
    
    # map_pixel_to_coords
    
    cpdef tuple map_pixel_to_coords(RenderWindowWrapper self, point, ViewWrapper view):
        return system.Vector2f_unpack(cgraphics.RenderWindow_map_pixel_to_coords(self.RenderWindow, system.Vector2i_cast(point), view.View))
    
    cpdef csystem.Vector2f map_pixel_to_coords_struct(RenderWindowWrapper self, csystem.Vector2i point, ViewWrapper view):
        return cgraphics.RenderWindow_map_pixel_to_coords(self.RenderWindow, point, view.View)
    
    cpdef tuple map_pixel_to_coords_xy(RenderWindowWrapper self, int x, int y, ViewWrapper view):
        return system.Vector2f_unpack(cgraphics.RenderWindow_map_pixel_to_coords(self.RenderWindow, system.Vector2i(x, y), view.View))
    
    # map_coords_to_pixel
    
    cpdef tuple map_coords_to_pixel(RenderWindowWrapper self, point, ViewWrapper view):
        return system.Vector2i_unpack(cgraphics.RenderWindow_map_coords_to_pixel(self.RenderWindow, system.Vector2f_cast(point), view.View))
    
    cpdef csystem.Vector2i map_coords_to_pixel_struct(RenderWindowWrapper self, csystem.Vector2f point, ViewWrapper view):
        return cgraphics.RenderWindow_map_coords_to_pixel(self.RenderWindow, point, view.View)
    
    cpdef tuple map_coords_to_pixel_xy(RenderWindowWrapper self, float x, float y, ViewWrapper view):
        return system.Vector2i_unpack(cgraphics.RenderWindow_map_coords_to_pixel(self.RenderWindow, system.Vector2f(x, y), view.View))
    
    # draw
    
    cpdef draw_sprite(RenderWindowWrapper self, SpriteWrapper sprite):
        cgraphics.RenderWindow_draw_sprite(self.RenderWindow, sprite.Sprite, RENDER_STATES_DEFAULT_PTR)
    
    cpdef draw_text(RenderWindowWrapper self, TextWrapper text):
        cgraphics.RenderWindow_draw_text(self.RenderWindow, text.Text, RENDER_STATES_DEFAULT_PTR)

    cpdef draw_shape(RenderWindowWrapper self, ShapeWrapper shape):
        cgraphics.RenderWindow_draw_shape(self.RenderWindow, shape.Shape, RENDER_STATES_DEFAULT_PTR)

    cpdef draw_circle_shape(RenderWindowWrapper self, CircleShapeWrapper circle_shape):
        cgraphics.RenderWindow_draw_circle_shape(self.RenderWindow, circle_shape.CircleShape, RENDER_STATES_DEFAULT_PTR)

    cpdef draw_convex_shape(RenderWindowWrapper self, ConvexShapeWrapper convex_shape):
        cgraphics.RenderWindow_draw_convex_shape(self.RenderWindow, convex_shape.ConvexShape, RENDER_STATES_DEFAULT_PTR)

    cpdef draw_rectangle_shape(RenderWindowWrapper self, RectangleShapeWrapper rectangle_shape):
        cgraphics.RenderWindow_draw_rectangle_shape(self.RenderWindow, rectangle_shape.RectangleShape, RENDER_STATES_DEFAULT_PTR)

    cpdef draw_vertex_array(RenderWindowWrapper self, VertexArrayWrapper vertex_array):
        cgraphics.RenderWindow_draw_vertex_array(self.RenderWindow, vertex_array.VertexArray, RENDER_STATES_DEFAULT_PTR)
    
    #cpdef draw_vertex_array_states(RenderWindowWrapper self, VertexArrayWrapper vertex_array, RenderStates states):
        #cgraphics.RenderWindow_draw_vertex_array(self.RenderWindow, vertex_array.VertexArray, &states.render_states)
    
    # TODO: vertices array
    #cpdef draw_primitives(RenderWindowWrapper self, Vertex vertices)
    
    # GL_states
    
    cpdef push_GL_states(RenderWindowWrapper self):
        cgraphics.RenderWindow_push_GL_states(self.RenderWindow)
    
    cpdef pop_GL_states(RenderWindowWrapper self):
        cgraphics.RenderWindow_pop_GL_states(self.RenderWindow)
    
    cpdef reset_GL_states(RenderWindowWrapper self):
        cgraphics.RenderWindow_reset_GL_states(self.RenderWindow)
    
    # Attributes
    
    # open
    
    cpdef bint is_open(RenderWindowWrapper self):
        return cgraphics.RenderWindow_is_open(self.RenderWindow)
    
    property open:
        def __get__(RenderWindowWrapper self):
            return cgraphics.RenderWindow_is_open(self.RenderWindow)
    
    # settings
    
    cpdef cwindow.ContextSettings get_settings(RenderWindowWrapper self):
        return cgraphics.RenderWindow_get_settings(self.RenderWindow)
    
    property settings:
        def __get__(RenderWindowWrapper self):
            return cgraphics.RenderWindow_get_settings(self.RenderWindow)
    
    # title
    
    cpdef set_title(RenderWindowWrapper self, const char* title):
        cgraphics.RenderWindow_set_title(self.RenderWindow, title)
    
    property title:
        def __set__(RenderWindowWrapper self, const char* title):
            cgraphics.RenderWindow_set_title(self.RenderWindow, title)
    
    # TODO: set_unicode_title
    
    # TODO: set_icon
    
    # visible
    
    cpdef set_visible(RenderWindowWrapper self, bint visible):
        cgraphics.RenderWindow_set_visible(self.RenderWindow, visible)
    
    property visible:
        def __set__(RenderWindowWrapper self, bint visible):
            cgraphics.RenderWindow_set_visible(self.RenderWindow, visible)
    
    # size
    
    cpdef tuple get_size(RenderWindowWrapper self):
        return system.Vector2u_unpack(cgraphics.RenderWindow_get_size(self.RenderWindow))
    
    cpdef csystem.Vector2u get_size_struct(RenderWindowWrapper self):
        return cgraphics.RenderWindow_get_size(self.RenderWindow)
    
    cpdef tuple get_size_xy(RenderWindowWrapper self):
        return system.Vector2u_unpack(cgraphics.RenderWindow_get_size(self.RenderWindow))
    
    cpdef set_size(RenderWindowWrapper self, size):
        cgraphics.RenderWindow_set_size(self.RenderWindow, system.Vector2u_cast(size))
    
    cpdef set_size_struct(RenderWindowWrapper self, csystem.Vector2u size):
        cgraphics.RenderWindow_set_size(self.RenderWindow, size)
    
    cpdef set_size_xy(RenderWindowWrapper self, unsigned int x, unsigned int y):
        cgraphics.RenderWindow_set_size(self.RenderWindow, system.Vector2u(x, y))
    
    property size:
        def __get__(RenderWindowWrapper self):
            return system.Vector2u_unpack(cgraphics.RenderWindow_get_size(self.RenderWindow))
        
        def __set__(RenderWindowWrapper self, size):
            cgraphics.RenderWindow_set_size(self.RenderWindow, system.Vector2u_cast(size))
    
    # width
    
    cpdef unsigned int get_width(RenderWindowWrapper self):
        return cgraphics.RenderWindow_get_size(self.RenderWindow).x
    
    cpdef set_width(RenderWindowWrapper self, unsigned int width):
        cgraphics.RenderWindow_set_size(self.RenderWindow, system.Vector2u(width, cgraphics.RenderWindow_get_size(self.RenderWindow).y))
    
    property width:
        def __get__(RenderWindowWrapper self):
            return cgraphics.RenderWindow_get_size(self.RenderWindow).x
        
        def __set__(RenderWindowWrapper self, unsigned int width):
            cgraphics.RenderWindow_set_size(self.RenderWindow, system.Vector2u(width, cgraphics.RenderWindow_get_size(self.RenderWindow).y))
    
    # height
    
    cpdef unsigned int get_height(RenderWindowWrapper self):
        return cgraphics.RenderWindow_get_size(self.RenderWindow).y
    
    cpdef set_height(RenderWindowWrapper self, unsigned int height):
        cgraphics.RenderWindow_set_size(self.RenderWindow, system.Vector2u(cgraphics.RenderWindow_get_size(self.RenderWindow).x, height))
    
    property height:
        def __get__(RenderWindowWrapper self):
            return cgraphics.RenderWindow_get_size(self.RenderWindow).y
    
        def __set__(RenderWindowWrapper self, unsigned int height):
            cgraphics.RenderWindow_set_size(self.RenderWindow, system.Vector2u(cgraphics.RenderWindow_get_size(self.RenderWindow).x, height))
    
    # active
    
    cpdef set_active(RenderWindowWrapper self, bint active):
        if not cgraphics.RenderWindow_set_active(self.RenderWindow, active):
            raise ValueError('Failed setting RenderWindowWrapper to be active.')
    
    property active:
        def __set__(RenderWindowWrapper self, bint active):
            self.set_active(active)
    
    # view
    
    cpdef ViewWrapper get_view(RenderWindowWrapper self):
        return View_wrap_ptr(cgraphics.RenderWindow_get_view(self.RenderWindow))
    
    cpdef set_view(RenderWindowWrapper self, ViewWrapper view):
        cgraphics.RenderWindow_set_view(self.RenderWindow, view.View)
    
    property view:
        def __get__(RenderWindowWrapper self):
            return View_wrap_ptr(cgraphics.RenderWindow_get_view(self.RenderWindow))
        
        def __set__(RenderWindowWrapper self, ViewWrapper view):
            cgraphics.RenderWindow_set_view(self.RenderWindow, view.View)
    
    # default_view
    
    cpdef ViewWrapper get_default_view(RenderWindowWrapper self):
        return View_wrap_ptr(cgraphics.RenderWindow_get_default_view(self.RenderWindow))
    
    property default_view:
        def __get__(RenderWindowWrapper self):
            return View_wrap_ptr(cgraphics.RenderWindow_get_default_view(self.RenderWindow))
    
    # vsync
    
    cpdef set_vsync(RenderWindowWrapper self, bint vsync):
        cgraphics.RenderWindow_set_vertical_sync_enabled(self.RenderWindow, vsync)
    
    property vsync:
        def __set__(RenderWindowWrapper self, bint vsync):
            cgraphics.RenderWindow_set_vertical_sync_enabled(self.RenderWindow, vsync)
    
    # mouse_cursor_visible
    
    cpdef set_mouse_cursor_visible(RenderWindowWrapper self, bint visible):
        cgraphics.RenderWindow_set_mouse_cursor_visible(self.RenderWindow, visible)
    
    property mouse_cursor_visible:
        def __set__(RenderWindowWrapper self, bint visible):
            cgraphics.RenderWindow_set_mouse_cursor_visible(self.RenderWindow, visible)
    
    # repeat_key_enabled
    
    cpdef set_key_repeat(RenderWindowWrapper self, bint enabled):
        cgraphics.RenderWindow_set_key_repeat_enabled(self.RenderWindow, enabled)
    
    property key_repeat:
        def __set__(RenderWindowWrapper self, bint enabled):
            cgraphics.RenderWindow_set_key_repeat_enabled(self.RenderWindow, enabled)
    
    # framerate_limit
    
    cpdef set_framerate_limit(RenderWindowWrapper self, unsigned int limit):
        cgraphics.RenderWindow_set_framerate_limit(self.RenderWindow, limit)
    
    property framerate_limit:
        def __set__(RenderWindowWrapper self, unsigned int limit):
            cgraphics.RenderWindow_set_framerate_limit(self.RenderWindow, limit)
    
    # joystick_threshold
    
    cpdef set_joystick_threshold(RenderWindowWrapper self, float threshold):
        cgraphics.RenderWindow_set_joystick_threshold(self.RenderWindow, threshold)
    
    property joystick_threshold:
        def __set__(RenderWindowWrapper self, float threshold):
            cgraphics.RenderWindow_set_joystick_threshold(self.RenderWindow, threshold)
    
    # Special methods
    
    def __dealloc__(RenderWindowWrapper self):
        if self.RenderWindow:
            cgraphics.RenderWindow_destroy(self.RenderWindow)


cdef class RenderWindow(RenderWindowWrapper):
    def __cinit__(
            RenderWindow self,
            unsigned int width,
            unsigned int height,
            unsigned int bits_per_pixel,
            const char* title,
            Uint32 style=cwindow.WINDOW_STYLE_DEFAULT):
        cdef cwindow.VideoMode video_mode
        video_mode.width = width
        video_mode.height = height
        video_mode.bits_per_pixel = bits_per_pixel
        cdef cwindow.ContextSettings context_settings = cwindow.ContextSettings()
        self.RenderWindow = cgraphics.RenderWindow_create(
            video_mode,
            title,
            style,
            &context_settings,
        )


cdef RenderWindowWrapper RenderWindow_create(
        window.VideoMode video_mode,
        const char* title,
        Uint32 style=cwindow.WINDOW_STYLE_DEFAULT):
    cdef cwindow.ContextSettings context_settings = cwindow.ContextSettings()
    return RenderWindow_wrap_ptr(cgraphics.RenderWindow_create(video_mode.VideoMode, title, style, &context_settings))


cdef RenderWindowWrapper RenderWindow_from_struct(
        cwindow.VideoMode video_mode,
        const char* title,
        Uint32 style=cwindow.WINDOW_STYLE_DEFAULT):
    cdef cwindow.ContextSettings context_settings = cwindow.ContextSettings()
    cdef cgraphics.RenderWindow* render_window_ptr = cgraphics.RenderWindow_create(video_mode, title, style, &context_settings)
    return RenderWindow_wrap_ptr(render_window_ptr)


cdef RenderWindowWrapper RenderWindow_wrap_ptr(cgraphics.RenderWindow* render_window_ptr):
    cdef RenderWindowWrapper render_window = RenderWindowWrapper()
    render_window.RenderWindow = render_window_ptr
    return render_window

