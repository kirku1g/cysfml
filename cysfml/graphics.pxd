from config cimport (
    Uint8,
    Uint32,
)

cimport cgraphics

cimport csystem
cimport system

cimport cwindow
cimport window

# Rect
#################################################################################


# FloatRect


cpdef cgraphics.FloatRect FloatRect(float left, float top, float width, float height)
cpdef tuple FloatRect_unpack(cgraphics.FloatRect rect)
cpdef cgraphics.FloatRect FloatRect_cast(value)


# FloatRect_contais

cpdef bint FloatRect_contains(rect, float x, float y)
cpdef bint FloatRect_contains_struct(cgraphics.FloatRect rect, float x, float y)
cdef bint FloatRect_contains_struct_ptr(cgraphics.FloatRect* rect, float x, float y)
cpdef bint FloatRect_contains_ltwh(
        float left,
        float top,
        float width,
        float height,
        float x,
        float y)


# FloatRect_intersects

cpdef tuple FloatRect_intersects(rect1, rect2)
cdef bint FloatRect_intersects_struct_ptr(
        cgraphics.FloatRect* rect1,
        cgraphics.FloatRect* rect2,
        cgraphics.FloatRect* intersection)
cpdef tuple FloatRect_intersects_ltwh(
        float left1,
        float top1,
        float width1,
        float height1,
        float left2,
        float top2,
        float width2,
        float height2)


# IntRect

cpdef cgraphics.IntRect IntRect(int left, int top, int width, int height)
cpdef tuple IntRect_unpack(cgraphics.IntRect rect)
cpdef cgraphics.IntRect IntRect_cast(value)


# IntRect_contais

cpdef bint IntRect_contains(rect, int x, int y)
cpdef bint IntRect_contains_struct(cgraphics.IntRect rect, int x, int y)
cdef bint IntRect_contains_struct_ptr(cgraphics.IntRect* rect, int x, int y)
cpdef bint IntRect_contains_ltwh(
        int left,
        int top,
        int width,
        int height,
        int x,
        int y)


# IntRect_intersects

cpdef tuple IntRect_intersects(rect1, rect2)
cdef bint IntRect_intersects_struct_ptr(
        cgraphics.IntRect* rect1,
        cgraphics.IntRect* rect2,
        cgraphics.IntRect* intersection)
cpdef tuple IntRect_intersects_ltwh(
        int left1,
        int top1,
        int width1,
        int height1,
        int left2,
        int top2,
        int width2,
        int height2)


# Color
#################################################################################

cpdef cgraphics.Color Color_from_rgb(Uint8 r, Uint8 g, Uint8 b)
cpdef cgraphics.Color Color_from_rgba(Uint8 r, Uint8 g, Uint8 b, Uint8 a)
cpdef cgraphics.Color Color_cast(value)
cpdef tuple Color_unpack_rgb(cgraphics.Color color)
cpdef tuple Color_unpack_rgba(cgraphics.Color color)


# Color_add

cpdef tuple Color_add(color1, color2)
cpdef cgraphics.Color Color_add_struct(cgraphics.Color color1, cgraphics.Color color2)
cpdef tuple Color_add_rgb(
        Uint8 r1, Uint8 g1, Uint8 b1,
        Uint8 r2, Uint8 g2, Uint8 b2)
cpdef tuple Color_add_rgba(
        Uint8 r1, Uint8 g1, Uint8 b1, Uint8 a1,
        Uint8 r2, Uint8 g2, Uint8 b2, Uint8 a2)


# Color_modulate

cpdef tuple Color_modulate(color1, color2)
cpdef cgraphics.Color Color_modulate_struct(cgraphics.Color color1, cgraphics.Color color2)
cpdef tuple Color_modulate_rgb(
        Uint8 r1, Uint8 g1, Uint8 b1,
        Uint8 r2, Uint8 g2, Uint8 b2)
cpdef tuple Color_modulate_rgba(
        Uint8 r1, Uint8 g1, Uint8 b1, Uint8 a1,
        Uint8 r2, Uint8 g2, Uint8 b2, Uint8 a2)


# Vertex
################################################################################

cpdef cgraphics.Vertex Vertex_cast(value) # position, color, tex_coords)
cpdef cgraphics.Vertex Vertex(csystem.Vector2f position, cgraphics.Color color, csystem.Vector2f tex_coords=*)
cpdef cgraphics.Vertex Vertex_from_args(float x, float y, Uint8 r, Uint8 g, Uint8 b, Uint8 a, float tex_x=*, float tex_y=*)


# Transform
################################################################################

cdef class TransformWrapper:
    '''
    Q: Does this need a class?    
    '''
    cdef cgraphics.Transform* Transform
    
    # Attributes
    
    # inverse
    
    cpdef TransformWrapper get_inverse(TransformWrapper self)
    cdef cgraphics.Transform get_inverse_struct(TransformWrapper self)
    
    # matrix
    
    cpdef tuple get_matrix(TransformWrapper self)
    cdef float* get_matrix_array(TransformWrapper self)
    
    # Cython methods
    
    # transform_rect
    
    cpdef tuple transform_rect(TransformWrapper self, rect)
    cpdef cgraphics.FloatRect transform_rect_struct(TransformWrapper self, cgraphics.FloatRect rect)
    cpdef tuple transform_rect_ltwh(TransformWrapper self, float left, float top, float width, float height)
    cpdef combine(TransformWrapper self, TransformWrapper transform)
    cdef combine_struct(TransformWrapper self, cgraphics.Transform transform)
    cpdef translate(TransformWrapper self, float x, float y)
    cpdef rotate(TransformWrapper self, float angle)
    cpdef rotate_with_center(TransformWrapper self, float angle, float x, float y)
    cpdef scale(TransformWrapper self, float scale_x, float scale_y)
    cpdef scale_with_center(TransformWrapper self, float scale_x, float scale_y, float center_x, float center_y)


cdef class Transform(TransformWrapper):
    pass


cdef TransformWrapper Transform_wrap_ptr(cgraphics.Transform* transform_ptr)
cdef TransformWrapper Transform_create()
cdef TransformWrapper Transform_from_matrix(
        float a00, float a01, float a02,
        float a10, float a11, float a12,
        float a20, float a21, float a22)


# Transformable
#################################################################################

cdef class TransformableWrapper:
    cdef cgraphics.Transformable* Transformable
    
    # Cython methods
    cpdef destroy(TransformableWrapper self)
    cpdef TransformableWrapper copy(TransformableWrapper self)
    # move
    cpdef move(TransformableWrapper self, offset)
    cpdef move_struct(TransformableWrapper self, csystem.Vector2f offset)
    cpdef move_xy(TransformableWrapper self, float x, float y)
    # rotate
    cpdef rotate(TransformableWrapper self, float angle)
    # scale_relative
    cpdef scale_relative(TransformableWrapper self, scale)
    cpdef scale_relative_struct(TransformableWrapper self, csystem.Vector2f scale)
    cpdef scale_relative_xy(TransformableWrapper self, float x, float y)
    # Attributes
    # position
    cpdef tuple get_position(TransformableWrapper self)
    cpdef csystem.Vector2f get_position_struct(TransformableWrapper self)
    cpdef tuple get_position_xy(TransformableWrapper self)
    cpdef set_position(TransformableWrapper self, position)
    cpdef set_position_struct(TransformableWrapper self, csystem.Vector2f position)
    cpdef set_position_xy(TransformableWrapper self, float x, float y)
    # rotation
    cpdef float get_rotation(TransformableWrapper self)
    cpdef set_rotation(TransformableWrapper self, float angle)
    # scale
    cpdef tuple get_scale(TransformableWrapper self)
    cpdef csystem.Vector2f get_scale_struct(TransformableWrapper self)
    cpdef tuple get_scale_xy(TransformableWrapper self)
    cpdef set_scale(TransformableWrapper self, scale)
    cpdef set_scale_struct(TransformableWrapper self, csystem.Vector2f scale)
    cpdef set_scale_xy(TransformableWrapper self, float x, float y)
    # origin
    cpdef set_origin(TransformableWrapper self, origin)
    cpdef set_origin_struct(TransformableWrapper self, csystem.Vector2f origin)
    cpdef set_origin_xy(TransformableWrapper self, float x, float y)
    cpdef tuple get_origin(TransformableWrapper self)
    cpdef csystem.Vector2f get_origin_struct(TransformableWrapper self)
    cpdef tuple get_origin_xy(TransformableWrapper self)
    # transform
    cpdef Transform get_transform(TransformableWrapper self)
    cdef cgraphics.Transform get_transform_struct(TransformableWrapper self)
    # inverse_transform
    cpdef Transform get_inverse_transform(TransformableWrapper self)
    cdef cgraphics.Transform get_inverse_transform_struct(TransformableWrapper self)


cdef class Transformable(TransformableWrapper):
    pass


cdef TransformableWrapper Transformable_wrap_ptr(cgraphics.Transformable* transformable_ptr)
cdef TransformableWrapper Transformable_create()


# Image
################################################################################

cdef ImageWrapper Image_wrap_ptr(cgraphics.Image* image_ptr)
cdef ImageWrapper Image_create(unsigned int width, unsigned int height)
cdef ImageWrapper Image_from_pixels(unsigned int width, unsigned int height, const Uint8* pixels)
cdef ImageWrapper Image_from_color(unsigned int width, unsigned int height, color)
cdef ImageWrapper Image_from_color_struct(unsigned int width, unsigned int height, cgraphics.Color color)
cdef ImageWrapper Image_from_color_rgb(unsigned int width, unsigned int height, Uint8 r, Uint8 g, Uint8 b)
cdef ImageWrapper Image_from_color_rgba(unsigned int width, unsigned int height, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
cdef ImageWrapper Image_from_file(const char* filename)
cdef ImageWrapper Image_from_memory(const void* data, size_t size)
cdef ImageWrapper Image_from_stream(system.InputStream stream)


cdef class ImageWrapper:
    cdef cgraphics.Image* Image
    
    # Cython methods
    cpdef destroy(ImageWrapper self)
    cpdef ImageWrapper copy(ImageWrapper self)
    cpdef copy_image(ImageWrapper self, ImageWrapper source, unsigned int dest_x, unsigned int dest_y, source_rect, bint apply_alpha)
    cpdef copy_image_struct(ImageWrapper self, ImageWrapper source, unsigned int dest_x, unsigned int dest_y, cgraphics.IntRect source_rect, bint apply_alpha)
    cpdef copy_image_ltwh(ImageWrapper self,
        ImageWrapper source,
        unsigned int dest_x,
        unsigned int dest_y,
        int source_left,
        int source_top,
        int source_width,
        int source_height,
        bint apply_alpha,
    )
    cpdef save_to_file(ImageWrapper self, const char* filename)
    # create_mask_from_color
    cpdef create_mask_from_color(ImageWrapper self, color, Uint8 alpha)
    cpdef create_mask_from_color_struct(ImageWrapper self, cgraphics.Color color, Uint8 alpha)
    cpdef create_mask_from_color_rgb(ImageWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 alpha)
    cpdef create_mask_from_color_rgba(ImageWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a, Uint8 alpha)
    cpdef set_pixel(ImageWrapper self, unsigned int x, unsigned int y, color)
    cpdef set_pixel_struct(ImageWrapper self, unsigned int x, unsigned int y, cgraphics.Color color)
    cpdef set_pixel_rgb(ImageWrapper self, unsigned int x, unsigned int y, Uint8 r, Uint8 g, Uint8 b)
    cpdef set_pixel_rgba(ImageWrapper self, unsigned int x, unsigned int y, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    cpdef cgraphics.Color get_pixel(ImageWrapper self, unsigned int x, unsigned int y)
    cpdef tuple get_pixel_rgb(ImageWrapper self, unsigned int x, unsigned int y)
    cpdef tuple get_pixel_rgba(ImageWrapper self, unsigned int x, unsigned int y)
    #cpdef Uint8* get_pixels(ImageWrapper self)
    cpdef flip_horizontally(ImageWrapper self)
    cpdef flip_vertically(ImageWrapper self)
    # Attributes
    # size
    cpdef tuple get_size(ImageWrapper self)
    cpdef csystem.Vector2u get_size_struct(ImageWrapper self)
    cpdef tuple get_size_xy(ImageWrapper self)


cdef class Image(ImageWrapper):
    pass


# Texture
################################################################################

cdef TextureWrapper Texture_wrap_ptr(cgraphics.Texture* texture_ptr)
cdef TextureWrapper Texture_create(unsigned int width, unsigned int height)
cdef TextureWrapper Texture_from_file(const char* filename)
cdef TextureWrapper Texture_from_file_area(const char* filename, area)
cdef TextureWrapper Texture_from_file_area_struct(const char* filename, const cgraphics.IntRect area)
cdef TextureWrapper Texture_from_file_area_ltwh(const char* filename, int left, int top, int width, int height)
cdef TextureWrapper Texture_from_file_area_ptr(const char* filename, const cgraphics.IntRect* area)
cdef TextureWrapper Texture_from_memory(const void* data, size_t size_in_bytes, cgraphics.IntRect* area)


cdef class TextureWrapper:
    cdef cgraphics.Texture* Texture
    
    # Cython methods
    cpdef destroy(TextureWrapper self)
    cpdef TextureWrapper copy(TextureWrapper self)
    cdef update_from_pixels(TextureWrapper self, const Uint8* pixels, unsigned int width, unsigned int height, unsigned int x, unsigned int y)
    cpdef update_from_image(TextureWrapper self, ImageWrapper image, unsigned int x, unsigned int y)
    cpdef update_from_window(TextureWrapper self, window.WindowWrapper window, unsigned int x, unsigned int y)
    #cpdef update_from_render_window(TextureWrapper self, RenderWindowWrapper render_window, unsigned int x, unsigned int y)
    cpdef ImageWrapper copy_to_image(TextureWrapper self)
    cpdef bind(TextureWrapper self)
    # Attributes
    # size
    cpdef tuple get_size(TextureWrapper self)
    cpdef csystem.Vector2u get_size_struct(TextureWrapper self)
    cpdef tuple get_size_xy(TextureWrapper self)
    cpdef unsigned int get_width(TextureWrapper self)
    cpdef unsigned int get_height(TextureWrapper self)
    # smooth
    cpdef bint is_smooth(TextureWrapper self)
    cpdef set_smooth(TextureWrapper self, bint smooth)
    # repeated
    cpdef bint is_repeated(TextureWrapper self)
    cpdef set_repeated(TextureWrapper self, bint repeated)


cdef class Texture(TextureWrapper):
    pass


cdef unsigned int Texture_get_maximum_size()


# Drawable
################################################################################

cdef class Drawable:
    cpdef draw(Drawable self, RenderWindowWrapper window)
    cdef draw_transform_struct(Drawable self, RenderWindowWrapper window, cgraphics.Transform transform)


# VertexArray
################################################################################

cdef class VertexArrayWrapper(Drawable):
    cdef cgraphics.VertexArray* VertexArray
    # Cython methods
    
    cpdef destroy(VertexArrayWrapper self)
    cpdef VertexArrayWrapper copy(VertexArrayWrapper self)
    cpdef clear(VertexArrayWrapper self)
    cpdef resize(VertexArrayWrapper self, unsigned int vertex_count)
    # append
    cpdef append(VertexArrayWrapper self, vertex)
    cpdef append_struct(VertexArrayWrapper self, cgraphics.Vertex vertex)
    cpdef append_args(VertexArrayWrapper self, float x, float y, Uint8 r, Uint8 g, Uint8 b, Uint8 a, float tex_x=*, float tex_y=*)
    # Attributes
    # vertex_count
    cpdef unsigned int get_vertex_count(VertexArrayWrapper self)
    cpdef tuple get_vertex(VertexArrayWrapper self, unsigned int index)
    cpdef cgraphics.Vertex get_vertex_struct(VertexArrayWrapper self, unsigned int index)
    # primitive_type
    cpdef cgraphics.PrimitiveType get_primitive_type(VertexArrayWrapper self)
    cpdef set_primitive_type(VertexArrayWrapper self, cgraphics.PrimitiveType type)
    # drawing
    cpdef draw(VertexArrayWrapper self, RenderWindowWrapper render_window)
    cdef draw_transform_struct(VertexArrayWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform)
    # bounds
    cpdef tuple get_bounds(VertexArrayWrapper self)
    cpdef cgraphics.FloatRect get_bounds_struct(VertexArrayWrapper self)
    cpdef tuple get_bounds_ltwh(VertexArrayWrapper self)


cdef class VertexArray(VertexArrayWrapper):
    pass

cdef VertexArrayWrapper VertexArray_wrap_ptr(cgraphics.VertexArray* vertex_array_ptr)
cdef VertexArrayWrapper VertexArray_create()


# Shape
################################################################################

cdef class ShapeWrapper(Drawable):
    cdef cgraphics.Shape* Shape
    # Attributes
    # position
    cpdef tuple get_position(ShapeWrapper self)
    cpdef csystem.Vector2f get_position_struct(ShapeWrapper self)
    cpdef tuple get_position_xy(ShapeWrapper self)
    cpdef set_position(ShapeWrapper self, position)
    cpdef set_position_struct(ShapeWrapper self, csystem.Vector2f position)
    cpdef set_position_xy(ShapeWrapper self, float x, float y)
    # rotation
    cpdef float get_rotation(ShapeWrapper self)
    cpdef set_rotation(ShapeWrapper self, float angle)
    # scale
    cpdef tuple get_scale(ShapeWrapper self)
    cpdef csystem.Vector2f get_scale_struct(ShapeWrapper self)
    cpdef tuple get_scale_xy(ShapeWrapper self)
    cpdef set_scale(ShapeWrapper self, scale)
    cpdef set_scale_struct(ShapeWrapper self, csystem.Vector2f scale)
    cpdef set_scale_xy(ShapeWrapper self, float x, float y)
    # origin
    cpdef tuple get_origin(ShapeWrapper self)
    cpdef csystem.Vector2f get_origin_struct(ShapeWrapper self)
    cpdef tuple get_origin_xy(ShapeWrapper self)
    cpdef set_origin(ShapeWrapper self, origin)
    cpdef set_origin_struct(ShapeWrapper self, csystem.Vector2f origin)
    cpdef set_origin_xy(ShapeWrapper self, float x, float y)
    # transform
    cpdef Transform get_transform(ShapeWrapper self)
    # inverse_transform
    cpdef Transform get_inverse_transform(ShapeWrapper self)
    # texture
    cpdef TextureWrapper get_texture(ShapeWrapper self)
    cpdef set_texture(ShapeWrapper self, TextureWrapper texture, bint reset_rect=*)
    # fill_color
    cpdef tuple get_fill_color(ShapeWrapper self)
    cpdef cgraphics.Color get_fill_color_struct(ShapeWrapper self)
    cpdef tuple get_fill_color_rgb(ShapeWrapper self)
    cpdef tuple get_fill_color_rgba(ShapeWrapper self)
    cpdef set_fill_color(ShapeWrapper self, fill_color)
    cpdef set_fill_color_struct(ShapeWrapper self, cgraphics.Color fill_color)
    cpdef set_fill_color_rgb(ShapeWrapper self, Uint8 r, Uint8 g, Uint8 b)
    cpdef set_fill_color_rgba(ShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    # outline_color
    cpdef cgraphics.Color get_outline_color(ShapeWrapper self)
    cpdef cgraphics.Color get_outline_color_struct(ShapeWrapper self)
    cpdef tuple get_outline_color_rgb(ShapeWrapper self)
    cpdef tuple get_outline_color_rgba(ShapeWrapper self)
    cpdef set_outline_color(ShapeWrapper self, outline_color)
    cpdef set_outline_color_struct(ShapeWrapper self, cgraphics.Color outline_color)
    cpdef set_outline_color_rgb(ShapeWrapper self, Uint8 r, Uint8 g, Uint8 b)
    cpdef set_outline_color_rgba(ShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    # outline_thickness
    cpdef float get_outline_thickness(ShapeWrapper self)
    cpdef set_outline_thickness(ShapeWrapper self, float thickness)
    # texture_rect
    cpdef tuple get_texture_rect(ShapeWrapper self)
    cpdef cgraphics.IntRect get_texture_rect_struct(ShapeWrapper self)
    cpdef tuple get_texture_rect_ltwh(ShapeWrapper self)
    cpdef set_texture_rect(ShapeWrapper self, rect)
    cpdef set_texture_rect_struct(ShapeWrapper self, cgraphics.IntRect rect)
    cpdef set_texture_rect_ltwh(ShapeWrapper self, int left, int top, int width, int height)
    # point_count
    cpdef unsigned int get_point_count(ShapeWrapper self)
    # local_bounds
    cpdef tuple get_local_bounds(ShapeWrapper self)
    cpdef cgraphics.FloatRect get_local_bounds_struct(ShapeWrapper self)
    cpdef tuple get_local_bounds_ltwh(ShapeWrapper self)
    # global_bounds
    cpdef tuple get_global_bounds(ShapeWrapper self)
    cpdef cgraphics.FloatRect get_global_bounds_struct(ShapeWrapper self)
    cpdef tuple get_global_bounds_ltwh(ShapeWrapper self)
    # Cython methods
    # move
    cpdef move(ShapeWrapper self, offset)
    cpdef move_struct(ShapeWrapper self, csystem.Vector2f offset)
    cpdef move_xy(ShapeWrapper self, float x, float y)
    # rotate
    cpdef rotate(ShapeWrapper self, float angle)
    # scale
    cpdef scale_relative(ShapeWrapper self, scale)
    cpdef scale_relative_struct(ShapeWrapper self, csystem.Vector2f scale)
    cpdef scale_relative_xy(ShapeWrapper self, float x, float y)
    # get_point
    cpdef tuple get_point(ShapeWrapper self, unsigned int index)
    cpdef csystem.Vector2f get_point_struct(ShapeWrapper self, unsigned int index)
    cpdef tuple get_point_xy(ShapeWrapper self, unsigned int index)
    cpdef update(ShapeWrapper self)
    cpdef destroy(ShapeWrapper self)
    # draw
    cpdef draw(ShapeWrapper self, RenderWindowWrapper render_window)
    cdef draw_transform_struct(ShapeWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform)


#cdef class Shape(ShapeWrapper):
    #pass


#cdef ShapeWrapper Shape_create()
cdef ShapeWrapper Shape_wrap_ptr(cgraphics.Shape* shape_ptr)


# CircleShape
################################################################################

cpdef CircleShapeWrapper CircleShape_create()
cdef CircleShapeWrapper CircleShape_wrap_ptr(cgraphics.CircleShape* circle_shape_ptr)


cdef class CircleShapeWrapper(Drawable):
    cdef cgraphics.CircleShape* CircleShape
    # Attributes
    # position
    cpdef tuple get_position(CircleShapeWrapper self)
    cpdef csystem.Vector2f get_position_struct(CircleShapeWrapper self)
    cpdef tuple get_position_xy(CircleShapeWrapper self)
    cpdef set_position(CircleShapeWrapper self, position)
    cpdef set_position_struct(CircleShapeWrapper self, csystem.Vector2f position)
    cpdef set_position_xy(CircleShapeWrapper self, float x, float y)
    # rotation
    cpdef float get_rotation(CircleShapeWrapper self)
    cpdef set_rotation(CircleShapeWrapper self, float angle)
    # scale
    cpdef tuple get_scale(CircleShapeWrapper self)
    cpdef csystem.Vector2f get_scale_struct(CircleShapeWrapper self)
    cpdef tuple get_scale_xy(CircleShapeWrapper self)
    cpdef set_scale(CircleShapeWrapper self, scale)
    cpdef set_scale_struct(CircleShapeWrapper self, csystem.Vector2f scale)
    cpdef set_scale_xy(CircleShapeWrapper self, float x, float y)
    # origin
    cpdef tuple get_origin(CircleShapeWrapper self)
    cpdef csystem.Vector2f get_origin_struct(CircleShapeWrapper self)
    cpdef tuple get_origin_xy(CircleShapeWrapper self)
    cpdef set_origin(CircleShapeWrapper self, origin)
    cpdef set_origin_struct(CircleShapeWrapper self, csystem.Vector2f origin)
    cpdef set_origin_xy(CircleShapeWrapper self, float x, float y)
    # transform
    cpdef Transform get_transform(CircleShapeWrapper self)
    cpdef Transform get_inverse_transform(CircleShapeWrapper self)
    # fill_color
    cpdef tuple get_fill_color(CircleShapeWrapper self)
    cpdef cgraphics.Color get_fill_color_struct(CircleShapeWrapper self)
    cpdef tuple get_fill_color_rgb(CircleShapeWrapper self)
    cpdef tuple get_fill_color_rgba(CircleShapeWrapper self)
    cpdef set_fill_color(CircleShapeWrapper self, fill_color)
    cpdef set_fill_color_struct(CircleShapeWrapper self, cgraphics.Color fill_color)
    cpdef set_fill_color_rgb(CircleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b)
    cpdef set_fill_color_rgba(CircleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    # outline_color
    cpdef tuple get_outline_color(CircleShapeWrapper self)
    cpdef cgraphics.Color get_outline_color_struct(CircleShapeWrapper self)
    cpdef tuple get_outline_color_rgb(CircleShapeWrapper self)
    cpdef tuple get_outline_color_rgba(CircleShapeWrapper self)
    cpdef set_outline_color(CircleShapeWrapper self, outline_color)
    cpdef set_outline_color_struct(CircleShapeWrapper self, cgraphics.Color outline_color)
    cpdef set_outline_color_rgb(CircleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b)
    cpdef set_outline_color_rgba(CircleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    # outline_thickness
    cpdef float get_outline_thickness(CircleShapeWrapper self)
    cpdef set_outline_thickness(CircleShapeWrapper self, float thickness)
    # texture
    cpdef TextureWrapper get_texture(CircleShapeWrapper self)
    cpdef set_texture(CircleShapeWrapper self, TextureWrapper texture, bint reset_rect=*)
    # texture_rect
    cpdef tuple get_texture_rect(CircleShapeWrapper self)
    cpdef cgraphics.IntRect get_texture_rect_struct(CircleShapeWrapper self)
    cpdef tuple get_texture_rect_ltwh(CircleShapeWrapper self)
    cpdef set_texture_rect(CircleShapeWrapper self, rect)
    cpdef set_texture_rect_struct(CircleShapeWrapper self, cgraphics.IntRect rect)
    cpdef set_texture_rect_ltwh(CircleShapeWrapper self, int left, int top, int width, int height)
    # point_count
    cpdef unsigned int get_point_count(CircleShapeWrapper self)
    cpdef set_point_count(CircleShapeWrapper self, unsigned int count)
    # radius
    cpdef float get_radius(CircleShapeWrapper self)
    cpdef set_radius(CircleShapeWrapper self, float radius)
    # local_bounds
    cpdef tuple get_local_bounds(CircleShapeWrapper self)
    cpdef cgraphics.FloatRect get_local_bounds_struct(CircleShapeWrapper self)
    cpdef tuple get_local_bounds_ltwh(CircleShapeWrapper self)
    # global_bounds
    cpdef tuple get_global_bounds(CircleShapeWrapper self)
    cpdef cgraphics.FloatRect get_global_bounds_struct(CircleShapeWrapper self)
    cpdef tuple get_global_bounds_ltwh(CircleShapeWrapper self)
    # Cython methods
    # move
    cpdef move(CircleShapeWrapper self, offset)
    cpdef move_struct(CircleShapeWrapper self, csystem.Vector2f offset)
    cpdef move_xy(CircleShapeWrapper self, float x, float y)
    # rotate
    cpdef rotate(CircleShapeWrapper self, float angle)
    # get_point
    cpdef tuple get_point(CircleShapeWrapper self, unsigned int index)
    cpdef csystem.Vector2f get_point_struct(CircleShapeWrapper self, unsigned int index)
    cpdef tuple get_point_xy(CircleShapeWrapper self, unsigned int index)
    # scale_relative
    cpdef scale_relative(CircleShapeWrapper self, scale)
    cpdef scale_relative_struct(CircleShapeWrapper self, csystem.Vector2f scale)
    cpdef scale_relative_xy(CircleShapeWrapper self, float x, float y)
    # drawing
    cpdef draw(CircleShapeWrapper self, RenderWindowWrapper render_window)
    cdef draw_transform_struct(CircleShapeWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform)


cdef class CircleShape(CircleShapeWrapper):
    pass


# ConvexShape
################################################################################

cpdef ConvexShapeWrapper ConvexShape_create()
cdef ConvexShapeWrapper ConvexShape_wrap_ptr(cgraphics.ConvexShape* convex_shape_ptr)


cdef class ConvexShapeWrapper(Drawable):
    cdef cgraphics.ConvexShape* ConvexShape
    # Attributes
    # position
    cpdef tuple get_position(ConvexShapeWrapper self)
    cpdef csystem.Vector2f get_position_struct(ConvexShapeWrapper self)
    cpdef tuple get_position_xy(ConvexShapeWrapper self)
    cpdef set_position(ConvexShapeWrapper self, position)
    cpdef set_position_struct(ConvexShapeWrapper self, csystem.Vector2f position)
    cpdef set_position_xy(ConvexShapeWrapper self, float x, float y)
    # rotation
    cpdef float get_rotation(ConvexShapeWrapper self)
    cpdef set_rotation(ConvexShapeWrapper self, float angle)
    # scale
    cpdef tuple get_scale(ConvexShapeWrapper self)
    cpdef csystem.Vector2f get_scale_struct(ConvexShapeWrapper self)
    cpdef tuple get_scale_xy(ConvexShapeWrapper self)
    cpdef set_scale(ConvexShapeWrapper self, scale)
    cpdef set_scale_struct(ConvexShapeWrapper self, csystem.Vector2f scale)
    cpdef set_scale_xy(ConvexShapeWrapper self, float x, float y)
    # origin
    cpdef tuple get_origin(ConvexShapeWrapper self)
    cpdef csystem.Vector2f get_origin_struct(ConvexShapeWrapper self)
    cpdef tuple get_origin_xy(ConvexShapeWrapper self)
    cpdef set_origin(ConvexShapeWrapper self, origin)
    cpdef set_origin_struct(ConvexShapeWrapper self, csystem.Vector2f origin)
    cpdef set_origin_xy(ConvexShapeWrapper self, float x, float y)
    # transform
    cpdef Transform get_transform(ConvexShapeWrapper self)
    # inverse_transform
    cpdef Transform get_inverse_transform(ConvexShapeWrapper self)
    # Cython methods
    # move
    cpdef move(ConvexShapeWrapper self, offset)
    cpdef move_struct(ConvexShapeWrapper self, csystem.Vector2f offset)
    cpdef move_xy(ConvexShapeWrapper self, float x, float y)
    # rotate
    cpdef rotate(ConvexShapeWrapper self, float angle)
    # scale_relative
    cpdef scale_relative(ConvexShapeWrapper self, scale)
    cpdef scale_relative_struct(ConvexShapeWrapper self, csystem.Vector2f scale)
    cpdef scale_relative_xy(ConvexShapeWrapper self, float x, float y)
    # fill_color
    cpdef tuple get_fill_color(ConvexShapeWrapper self)
    cpdef cgraphics.Color get_fill_color_struct(ConvexShapeWrapper self)
    cpdef tuple get_fill_color_rgb(ConvexShapeWrapper self)
    cpdef tuple get_fill_color_rgba(ConvexShapeWrapper self)
    cpdef set_fill_color(ConvexShapeWrapper self, fill_color)
    cpdef set_fill_color_struct(ConvexShapeWrapper self, cgraphics.Color fill_color)
    cpdef set_fill_color_rgb(ConvexShapeWrapper self, Uint8 r, Uint8 g, Uint8 b)
    cpdef set_fill_color_rgba(ConvexShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    # outline_color
    cpdef tuple get_outline_color(ConvexShapeWrapper self)
    cpdef cgraphics.Color get_outline_color_struct(ConvexShapeWrapper self)
    cpdef tuple get_outline_color_rgb(ConvexShapeWrapper self)
    cpdef tuple get_outline_color_rgba(ConvexShapeWrapper self)
    cpdef set_outline_color(ConvexShapeWrapper self, outline_color)
    cpdef set_outline_color_struct(ConvexShapeWrapper self, cgraphics.Color outline_color)
    cpdef set_outline_color_rgb(ConvexShapeWrapper self, Uint8 r, Uint8 g, Uint8 b)
    cpdef set_outline_color_rgba(ConvexShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    # outline_thickness
    cpdef float get_outline_thickness(ConvexShapeWrapper self)
    cpdef set_outline_thickness(ConvexShapeWrapper self, float thickness)
    # texture
    cpdef TextureWrapper get_texture(ConvexShapeWrapper self)
    cpdef set_texture(ConvexShapeWrapper self, TextureWrapper texture, bint reset_rect=*)
    # texture_rect
    cpdef tuple get_texture_rect(ConvexShapeWrapper self)
    cpdef cgraphics.IntRect get_texture_rect_struct(ConvexShapeWrapper self)
    cpdef tuple get_texture_rect_ltwh(ConvexShapeWrapper self)
    cpdef set_texture_rect(ConvexShapeWrapper self, rect)
    cpdef set_texture_rect_struct(ConvexShapeWrapper self, cgraphics.IntRect rect)
    cpdef set_texture_rect_ltwh(ConvexShapeWrapper self, int left, int top, int width, int height)
    
    # point_count
    cpdef unsigned int get_point_count(ConvexShapeWrapper self)
    cpdef set_point_count(ConvexShapeWrapper self, unsigned int count)
    # get_point
    cpdef tuple get_point(ConvexShapeWrapper self, unsigned int index)
    cpdef csystem.Vector2f get_point_struct(ConvexShapeWrapper self, unsigned int index)
    cpdef tuple get_point_xy(ConvexShapeWrapper self, unsigned int index)
    # set_point
    cpdef set_point(ConvexShapeWrapper self, unsigned int index, point)
    cpdef set_point_struct(ConvexShapeWrapper self, unsigned int index, csystem.Vector2f point)
    cpdef set_point_xy(ConvexShapeWrapper self, unsigned int index, float x, float y)
    # local_bounds
    cpdef tuple get_local_bounds(ConvexShapeWrapper self)
    cpdef cgraphics.FloatRect get_local_bounds_struct(ConvexShapeWrapper self)
    cpdef tuple get_local_bounds_ltwh(ConvexShapeWrapper self)
    # global_bounds
    cpdef tuple get_global_bounds(ConvexShapeWrapper self)
    cpdef cgraphics.FloatRect get_global_bounds_struct(ConvexShapeWrapper self)
    cpdef tuple get_global_bounds_ltwh(ConvexShapeWrapper self)
    # drawing
    cpdef draw(ConvexShapeWrapper self, RenderWindowWrapper render_window)
    cdef draw_transform_struct(ConvexShapeWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform)


cdef class ConvexShape(ConvexShapeWrapper):
    pass


# RectangleShape
################################################################################

cpdef RectangleShapeWrapper RectangleShape_create()
cdef RectangleShapeWrapper RectangleShape_wrap_ptr(cgraphics.RectangleShape* rectangle_shape_ptr)


cdef class RectangleShapeWrapper(Drawable):
    cdef cgraphics.RectangleShape* RectangleShape
    # Attributes
    # position
    cpdef tuple get_position(RectangleShapeWrapper self)
    cpdef csystem.Vector2f get_position_struct(RectangleShapeWrapper self)
    cpdef tuple get_position_xy(RectangleShapeWrapper self)
    cpdef set_position(RectangleShapeWrapper self, position)
    cpdef set_position_struct(RectangleShapeWrapper self, csystem.Vector2f position)
    cpdef set_position_xy(RectangleShapeWrapper self, float x, float y)
    # rotation
    cpdef float get_rotation(RectangleShapeWrapper self)
    cpdef set_rotation(RectangleShapeWrapper self, float angle)
    # scale
    cpdef tuple get_scale(RectangleShapeWrapper self)
    cpdef csystem.Vector2f get_scale_struct(RectangleShapeWrapper self)
    cpdef tuple get_scale_xy(RectangleShapeWrapper self)
    cpdef set_scale(RectangleShapeWrapper self, scale)
    cpdef set_scale_struct(RectangleShapeWrapper self, csystem.Vector2f scale)
    cpdef set_scale_xy(RectangleShapeWrapper self, float x, float y)
    # origin
    cpdef tuple get_origin(RectangleShapeWrapper self)
    cpdef csystem.Vector2f get_origin_struct(RectangleShapeWrapper self)
    cpdef tuple get_origin_xy(RectangleShapeWrapper self)
    cpdef set_origin(RectangleShapeWrapper self, origin)
    cpdef set_origin_struct(RectangleShapeWrapper self, csystem.Vector2f origin)
    cpdef set_origin_xy(RectangleShapeWrapper self, float x, float y)
    # Cython methods
    # move
    cpdef move(RectangleShapeWrapper self, offset)
    cpdef move_struct(RectangleShapeWrapper self, csystem.Vector2f offset)
    cpdef move_xy(RectangleShapeWrapper self, float x, float y)
    # rotate
    cpdef rotate(RectangleShapeWrapper self, float angle)
    # scale_relative
    cpdef scale_relative(RectangleShapeWrapper self, scale)
    cpdef scale_relative_struct(RectangleShapeWrapper self, csystem.Vector2f scale)
    cpdef scale_relative_xy(RectangleShapeWrapper self, float x, float y)
    # transform
    cpdef Transform get_transform(RectangleShapeWrapper self)
    # inverse_transform
    cpdef Transform get_inverse_transform(RectangleShapeWrapper self)
    # texture_rect
    cpdef tuple get_texture_rect(RectangleShapeWrapper self)
    cpdef cgraphics.IntRect get_texture_rect_struct(RectangleShapeWrapper self)
    cpdef tuple get_texture_rect_ltwh(RectangleShapeWrapper self)
    cpdef set_texture_rect(RectangleShapeWrapper self, rect)
    cpdef set_texture_rect_struct(RectangleShapeWrapper self, cgraphics.IntRect rect)
    cpdef set_texture_rect_ltwh(RectangleShapeWrapper self, int left, int top, int width, int height)
    # fill_color
    cpdef tuple get_fill_color(RectangleShapeWrapper self)
    cpdef cgraphics.Color get_fill_color_struct(RectangleShapeWrapper self)
    cpdef tuple get_fill_color_rgb(RectangleShapeWrapper self)
    cpdef tuple get_fill_color_rgba(RectangleShapeWrapper self)
    cpdef set_fill_color(RectangleShapeWrapper self, fill_color)
    cpdef set_fill_color_struct(RectangleShapeWrapper self, cgraphics.Color fill_color)
    cpdef set_fill_color_rgb(RectangleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b)
    cpdef set_fill_color_rgba(RectangleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    # outline_color
    cpdef tuple get_outline_color(RectangleShapeWrapper self)
    cpdef cgraphics.Color get_outline_color_struct(RectangleShapeWrapper self)
    cpdef tuple get_outline_color_rgb(RectangleShapeWrapper self)
    cpdef tuple get_outline_color_rgba(RectangleShapeWrapper self)
    cpdef set_outline_color(RectangleShapeWrapper self, outline_color)
    cpdef set_outline_color_struct(RectangleShapeWrapper self, cgraphics.Color outline_color)
    cpdef set_outline_color_rgb(RectangleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b)
    cpdef set_outline_color_rgba(RectangleShapeWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    # outline_thickness
    cpdef float get_outline_thickness(RectangleShapeWrapper self)
    cpdef set_outline_thickness(RectangleShapeWrapper self, float thickness)
    # texture
    cpdef TextureWrapper get_texture(RectangleShapeWrapper self)
    cpdef set_texture(RectangleShapeWrapper self, TextureWrapper texture, bint reset_rect=*)
    # get_point_count
    cpdef unsigned int get_point_count(RectangleShapeWrapper self)
    # get_point
    cpdef tuple get_point(RectangleShapeWrapper self, unsigned int index)
    cpdef csystem.Vector2f get_point_struct(RectangleShapeWrapper self, unsigned int index)
    cpdef tuple get_point_xy(RectangleShapeWrapper self, unsigned int index)
    # size
    cpdef tuple get_size(RectangleShapeWrapper self)
    cpdef csystem.Vector2f get_size_struct(RectangleShapeWrapper self)
    cpdef tuple get_size_xy(RectangleShapeWrapper self)
    cpdef set_size(RectangleShapeWrapper self, size)
    cpdef set_size_struct(RectangleShapeWrapper self, csystem.Vector2f size)
    cpdef set_size_xy(RectangleShapeWrapper self, float x, float y)
    # local_bounds
    cpdef tuple get_local_bounds(RectangleShapeWrapper self)
    cpdef cgraphics.FloatRect get_local_bounds_struct(RectangleShapeWrapper self)
    cpdef tuple get_local_bounds_ltwh(RectangleShapeWrapper self)
    # global_bounds
    cpdef tuple get_global_bounds(RectangleShapeWrapper self)
    cpdef cgraphics.FloatRect get_global_bounds_struct(RectangleShapeWrapper self)
    cpdef tuple get_global_bounds_ltwh(RectangleShapeWrapper self)
    # drawing
    cpdef draw(RectangleShapeWrapper self, RenderWindowWrapper render_window)
    cdef draw_transform_struct(RectangleShapeWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform)


cdef class RectangleShape(RectangleShapeWrapper):
    pass


# Sprite
################################################################################

cdef SpriteWrapper Sprite_wrap_ptr(cgraphics.Sprite* sprite_ptr)
cdef SpriteWrapper Sprite_create()
cdef SpriteWrapper Sprite_from_texture(TextureWrapper texture)
cdef SpriteWrapper Sprite_from_file(const char* filename)


cdef class SpriteWrapper(Drawable):
    cdef cgraphics.Sprite* Sprite
    # Cython methods
    cpdef SpriteWrapper copy(SpriteWrapper self)
    cpdef destroy(SpriteWrapper self)
    # Attributes
    # position
    cpdef tuple get_position(SpriteWrapper self)
    cpdef csystem.Vector2f get_position_struct(SpriteWrapper self)
    cpdef tuple get_position_xy(SpriteWrapper self)
    cpdef set_position(SpriteWrapper self, position)
    cpdef set_position_struct(SpriteWrapper self, csystem.Vector2f position)
    cpdef set_position_xy(SpriteWrapper self, float x, float y)
    # rotation
    cpdef float get_rotation(SpriteWrapper self)
    cpdef set_rotation(SpriteWrapper self, float angle)
    # scale
    cpdef tuple get_scale(SpriteWrapper self)
    cpdef csystem.Vector2f get_scale_struct(SpriteWrapper self)
    cpdef tuple get_scale_xy(SpriteWrapper self)
    cpdef set_scale(SpriteWrapper self, scale)
    cpdef set_scale_struct(SpriteWrapper self, csystem.Vector2f scale)
    cpdef set_scale_xy(SpriteWrapper self, float x, float y)
    # origin
    cpdef tuple get_origin(SpriteWrapper self)
    cpdef csystem.Vector2f get_origin_struct(SpriteWrapper self)
    cpdef tuple get_origin_xy(SpriteWrapper self)
    cpdef set_origin(SpriteWrapper self, origin)
    cpdef set_origin_struct(SpriteWrapper self, csystem.Vector2f origin)
    cpdef set_origin_xy(SpriteWrapper self, float x, float y)
    # move
    cpdef move(SpriteWrapper self, offset)
    cpdef move_struct(SpriteWrapper self, csystem.Vector2f offset)
    cpdef move_xy(SpriteWrapper self, float x, float y)
    # rotate
    cpdef rotate(SpriteWrapper self, float angle)
    # scale_relative
    cpdef scale_relative(SpriteWrapper self, factors)
    cpdef scale_relative_struct(SpriteWrapper self, csystem.Vector2f factors)
    cpdef scale_relative_xy(SpriteWrapper self, float x, float y)
    # texture
    cpdef TextureWrapper get_texture(SpriteWrapper self)
    cpdef set_texture(SpriteWrapper self, TextureWrapper texture, bint reset_rect=*)
    # texture_rect
    cpdef tuple get_texture_rect(SpriteWrapper self)
    cpdef cgraphics.IntRect get_texture_rect_struct(SpriteWrapper self)
    cpdef tuple get_texture_rect_ltwh(SpriteWrapper self)
    cpdef set_texture_rect(SpriteWrapper self, rect)
    cpdef set_texture_rect_struct(SpriteWrapper self, cgraphics.IntRect rect)
    cpdef set_texture_rect_ltwh(SpriteWrapper self, int left, int top, int width, int height)
    # transform
    cpdef Transform get_transform(SpriteWrapper self)
    # inverse_transform
    cpdef Transform get_inverse_transform(SpriteWrapper self)
    # color
    cpdef get_color(SpriteWrapper self)
    cpdef cgraphics.Color get_color_struct(SpriteWrapper self)
    cpdef tuple get_color_rgb(SpriteWrapper self)
    cpdef tuple get_color_rgba(SpriteWrapper self)
    cpdef set_color(SpriteWrapper self, color)
    cpdef set_color_struct(SpriteWrapper self, cgraphics.Color color)
    cpdef set_color_rgb(SpriteWrapper self, Uint8 r, Uint8 g, Uint8 b)
    cpdef set_color_rgba(SpriteWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    # local_bounds
    cpdef tuple get_local_bounds(SpriteWrapper self)
    cpdef cgraphics.FloatRect get_local_bounds_struct(SpriteWrapper self)
    cpdef tuple get_local_bounds_ltwh(SpriteWrapper self)
    # global_bounds
    cpdef tuple get_global_bounds(SpriteWrapper self)
    cpdef cgraphics.FloatRect get_global_bounds_struct(SpriteWrapper self)
    cpdef tuple get_global_bounds_ltwh(SpriteWrapper self)
    # drawing
    cpdef draw(SpriteWrapper self, RenderWindowWrapper render_window)
    cdef draw_transform_struct(SpriteWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform)


cdef class Sprite(SpriteWrapper):
    pass


# Font
################################################################################

cdef FontWrapper Font_wrap_ptr(cgraphics.Font* font_ptr)
cdef FontWrapper Font_from_file(const char* filename)
cdef FontWrapper Font_from_memory(const void* data, size_t size_in_bytes)


cdef class FontWrapper:
    cdef cgraphics.Font* Font
    # Cython methods
    cpdef FontWrapper copy(FontWrapper self)
    cpdef destroy(FontWrapper self)
    cpdef cgraphics.Glyph get_glyph(FontWrapper self, unsigned int code_point, unsigned int character_size, bint bold)
    cpdef int get_kerning(FontWrapper self, unsigned int first, unsigned int second, unsigned int character_size)
    cpdef int get_line_spacing(FontWrapper self, unsigned int character_size)
    cpdef TextureWrapper get_texture(FontWrapper self, unsigned int character_size)


cdef class Font(FontWrapper):
    pass


# Text
################################################################################

cdef TextWrapper Text_wrap_ptr(cgraphics.Text* text_ptr)
cdef TextWrapper Text_create()


cdef class TextWrapper(Drawable):
    cdef cgraphics.Text* Text
    # Cython methods
    cpdef TextWrapper copy(TextWrapper self)
    cpdef destroy(TextWrapper self)
    # Attributes
    # position
    cpdef tuple get_position(TextWrapper self)
    cpdef csystem.Vector2f get_position_struct(TextWrapper self)
    cpdef tuple get_position_xy(TextWrapper self)
    cpdef set_position(TextWrapper self, position)
    cpdef set_position_struct(TextWrapper self, csystem.Vector2f position)
    cpdef set_position_xy(TextWrapper self, float x, float y)
    # rotation
    cpdef float get_rotation(TextWrapper self)
    cpdef set_rotation(TextWrapper self, float angle)
    # scale
    cpdef tuple get_scale(TextWrapper self)
    cpdef csystem.Vector2f get_scale_struct(TextWrapper self)
    cpdef tuple get_scale_xy(TextWrapper self)
    cpdef set_scale(TextWrapper self, scale)
    cpdef set_scale_struct(TextWrapper self, csystem.Vector2f scale)
    cpdef set_scale_xy(TextWrapper self, float x, float y)
    # origin
    cpdef tuple get_origin(TextWrapper self)
    cpdef csystem.Vector2f get_origin_struct(TextWrapper self)
    cpdef tuple get_origin_xy(TextWrapper self)
    cpdef set_origin(TextWrapper self, origin)
    cpdef set_origin_struct(TextWrapper self, csystem.Vector2f origin)
    cpdef set_origin_xy(TextWrapper self, float x, float y)
    # move
    cpdef move(TextWrapper self, offset)
    cpdef move_struct(TextWrapper self, csystem.Vector2f offset)
    cpdef move_xy(TextWrapper self, float x, float y)
    # rotate
    cpdef rotate(TextWrapper self, float angle)
    # scale_relative
    cpdef scale_relative(TextWrapper self, scale)
    cpdef scale_relative_struct(TextWrapper self, csystem.Vector2f scale)
    cpdef scale_relative_xy(TextWrapper self, float x, float y)
    # transform
    cpdef TransformWrapper get_transform(TextWrapper self)
    # inverse_transform
    cpdef TransformWrapper get_inverse_transform(TextWrapper self)
    # string
    cdef char* get_string(TextWrapper self)
    cpdef set_string(TextWrapper self, const char* string)
    # TODO: Unicode string
    # font
    cpdef FontWrapper get_font(TextWrapper self)
    cpdef set_font(TextWrapper self, FontWrapper font)
    # character_size
    cpdef unsigned int get_character_size(TextWrapper self)
    cpdef set_character_size(TextWrapper self, unsigned int size)
    # style
    cpdef unsigned int get_style(TextWrapper self)
    cpdef set_style(TextWrapper self, unsigned int style)
    # color
    cpdef tuple get_color(TextWrapper self)
    cpdef cgraphics.Color get_color_struct(TextWrapper self)
    cpdef tuple get_color_rgb(TextWrapper self)
    cpdef tuple get_color_rgba(TextWrapper self)
    cpdef set_color(TextWrapper self, color)
    cpdef set_color_struct(TextWrapper self, cgraphics.Color color)
    cpdef set_color_rgb(TextWrapper self, Uint8 r, Uint8 g, Uint8 b)
    cpdef set_color_rgba(TextWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    # TODO: Unicode string
    # find_character_pos
    cpdef tuple find_character_pos(TextWrapper self, size_t index)
    cpdef csystem.Vector2f find_character_pos_struct(TextWrapper self, size_t index)
    cpdef tuple find_character_pos_xy(TextWrapper self, size_t index)
    # local_bounds
    cpdef tuple get_local_bounds(TextWrapper self)
    cpdef cgraphics.FloatRect get_local_bounds_struct(TextWrapper self)
    cpdef tuple get_local_bounds_ltwh(TextWrapper self)
    # global_bounds
    cpdef tuple get_global_bounds(TextWrapper self)
    cpdef cgraphics.FloatRect get_global_bounds_struct(TextWrapper self)
    cpdef tuple get_global_bounds_ltwh(TextWrapper self)
    # drawing
    cpdef draw(TextWrapper self, RenderWindowWrapper render_window)
    cdef draw_transform_struct(TextWrapper self, RenderWindowWrapper render_window, cgraphics.Transform transform)


cdef class Text(TextWrapper):
    pass


# View
#################################################################################

cdef class ViewWrapper:
    cdef cgraphics.View* View
    # Attributes
    # center
    cpdef tuple get_center(ViewWrapper self)
    cpdef csystem.Vector2f get_center_struct(ViewWrapper self)
    cpdef tuple get_center_xy(ViewWrapper self)
    cpdef set_center(ViewWrapper self, center)
    cpdef set_center_struct(ViewWrapper self, csystem.Vector2f center)
    cpdef set_center_xy(ViewWrapper self, float x, float y)
    # size
    cpdef tuple get_size(ViewWrapper self)
    cpdef csystem.Vector2f get_size_struct(ViewWrapper self)
    cpdef tuple get_size_xy(ViewWrapper self)
    cpdef set_size(ViewWrapper self, size)
    cpdef set_size_struct(ViewWrapper self, csystem.Vector2f size)
    cpdef set_size_xy(ViewWrapper self, float x, float y)
    # rotation
    cpdef float get_rotation(ViewWrapper self)
    cpdef set_rotation(ViewWrapper self, float angle)
    # viewport
    cpdef tuple get_viewport(ViewWrapper self)
    cpdef cgraphics.FloatRect get_viewport_struct(ViewWrapper self)
    cpdef tuple get_viewport_ltwh(ViewWrapper self)
    cpdef set_viewport(ViewWrapper self, viewport)
    cpdef set_viewport_struct(ViewWrapper self, cgraphics.FloatRect viewport)
    cpdef set_viewport_ltwh(ViewWrapper self, float length, float top, float width, float height)
    # Cython methods
    # reset
    cpdef reset(ViewWrapper self, rectangle)
    cpdef reset_struct(ViewWrapper self, cgraphics.FloatRect rectangle)
    # move
    cpdef move(ViewWrapper self, offset)
    cpdef move_struct(ViewWrapper self, csystem.Vector2f offset)
    cpdef move_xy(ViewWrapper self, float x, float y)
    # rotate
    cpdef rotate(ViewWrapper self, float angle)
    # zoom
    cpdef zoom(ViewWrapper self, float factor)


cdef class View(ViewWrapper):
    pass


cdef ViewWrapper View_wrap_ptr(cgraphics.View* view_ptr)
cdef ViewWrapper View_create()
cdef ViewWrapper View_from_rect(rect)
cdef ViewWrapper View_from_rect_struct(cgraphics.FloatRect rect)
cdef ViewWrapper View_from_rect_ltwh(float left, float top, float width, float height)


# Shader
################################################################################

cdef ShaderWrapper Shader_wrap_ptr(cgraphics.Shader* shader_ptr)
cdef ShaderWrapper Shader_from_file(const char* vertex_shader_filename, const char* fragment_shader_filename)
cdef ShaderWrapper Shader_from_memory(const char* vertex_shader, const char* fragment_shader)
cdef ShaderWrapper Shader_from_stream(system.InputStream vertex_shader, system.InputStream fragment_shader)
cdef ShaderWrapper Shader_from_stream_ptr(csystem.InputStream* vertex_shader, csystem.InputStream* fragment_shader)
cdef bint Shader_is_available()


cdef class ShaderWrapper:
    cdef cgraphics.Shader* Shader
    # Cython methods
    cpdef destroy(ShaderWrapper self)
    cpdef set_float_parameter(ShaderWrapper self, const char* name, float x)
    cpdef set_float2_parameter(ShaderWrapper self, const char* name, float x, float y)
    cpdef set_float3_parameter(ShaderWrapper self, const char* name, float x, float y, float z)
    cpdef set_float4_parameter(ShaderWrapper self, const char* name, float x, float y, float z, float w)
    cpdef set_vector2_parameter(ShaderWrapper self, const char* name, csystem.Vector2f vector)
    cpdef set_vector2_parameter_xy(ShaderWrapper self, const char* name, float x, float y)
    cpdef set_vector3_parameter(ShaderWrapper self, const char* name, cgraphics.Vector3f vector)
    cpdef set_vector3_parameter_xyz(ShaderWrapper self, const char* name, float x, float y, float z)
    cpdef set_color_parameter(ShaderWrapper self, const char* name, cgraphics.Color color)
    cpdef set_transform_parameter(ShaderWrapper self, const char* name, Transform transform)
    cdef set_transform_parameter_struct(ShaderWrapper self, const char* name, cgraphics.Transform transform_struct)
    cpdef set_texture_parameter(ShaderWrapper self, const char* name, Texture texture)
    cdef set_texture_parameter_ptr(ShaderWrapper self, const char* name, cgraphics.Texture* texture_ptr)
    cpdef set_current_texture_parameter(ShaderWrapper self, const char* name)
    cpdef bind(ShaderWrapper self)


cdef class Shader(ShaderWrapper):
    pass



# RenderStates
################################################################################

cdef class RenderStates:
    cdef cgraphics.RenderStates RenderStates
    # blend_mode
    cpdef cgraphics.BlendMode get_blend_mode(RenderStates self)
    cpdef set_blend_mode(RenderStates self, cgraphics.BlendMode blend_mode)
    # transform
    cpdef Transform get_transform(RenderStates self)
    cpdef set_transform(RenderStates self, Transform transform)
    # texture
    cpdef TextureWrapper get_texture(RenderStates self)
    cpdef set_texture(RenderStates self, TextureWrapper texture)
    # shader
    cpdef Shader get_shader(RenderStates self)
    cpdef set_shader(RenderStates self, Shader shader)


cdef RenderStates RenderStates_create()
cdef cgraphics.RenderStates* RenderStates_ptr_from_transform(cgraphics.Transform transform)


#cdef RenderStates RENDER_STATES_DEFAULT = RenderStates_create()
#cdef cgraphics.RenderStates* RENDER_STATES_DEFAULT_PTR = &RENDER_STATES_DEFAULT.RenderStates



# RenderTexture
################################################################################

cdef class RenderTextureWrapper:
    cdef cgraphics.RenderTexture* RenderTexture
    # Cython methods
    cpdef display(RenderTextureWrapper self)
    cpdef destroy(RenderTextureWrapper self)
    # clear
    cpdef clear(RenderTextureWrapper self, color)
    cpdef clear_struct(RenderTextureWrapper self, cgraphics.Color color)
    cpdef clear_rgb(RenderTextureWrapper self, Uint8 r, Uint8 g, Uint8 b)
    cpdef clear_rgba(RenderTextureWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    # viewport
    cpdef tuple get_viewport(RenderTextureWrapper self, ViewWrapper view)
    cpdef cgraphics.IntRect get_viewport_struct(RenderTextureWrapper self, ViewWrapper view)
    cpdef tuple get_viewport_ltwh(RenderTextureWrapper self, ViewWrapper view)
    # map_pixel_to_coords
    cpdef tuple map_pixel_to_coords(RenderTextureWrapper self, point, ViewWrapper view)
    cpdef csystem.Vector2f map_pixel_to_coords_struct(RenderTextureWrapper self, csystem.Vector2i point, ViewWrapper view)
    cpdef tuple map_pixel_to_coords_xy(RenderTextureWrapper self, int x, int y, ViewWrapper view)
    # map_coords_to_pixel
    cpdef tuple map_coords_to_pixel(RenderTextureWrapper self, point, ViewWrapper view)
    cpdef csystem.Vector2i map_coords_to_pixel_struct(RenderTextureWrapper self, csystem.Vector2f point, ViewWrapper view)
    cpdef tuple map_coords_to_pixel_xy(RenderTextureWrapper self, float x, float y, ViewWrapper view)
    # draw
    cpdef draw_sprite(RenderTextureWrapper self, SpriteWrapper sprite)
    cpdef draw_text(RenderTextureWrapper self, TextWrapper text)
    cpdef draw_shape(RenderTextureWrapper self, ShapeWrapper shape)
    cpdef draw_circle_shape(RenderTextureWrapper self, CircleShapeWrapper circle_shape)
    cpdef draw_convex_shape(RenderTextureWrapper self, ConvexShapeWrapper convex_shape)
    cpdef draw_rectangle_shape(RenderTextureWrapper self, RectangleShapeWrapper rectangle_shape)
    cpdef draw_vertex_array(RenderTextureWrapper self, VertexArrayWrapper vertex_array)
    # TODO: vertices array
    #cpdef draw_primitives(RenderTextureWrapper self, Vertex vertices)
    # GL_states
    cpdef push_GL_states(RenderTextureWrapper self)
    cpdef pop_GL_states(RenderTextureWrapper self)
    cpdef reset_GL_states(RenderTextureWrapper self)
    # Attributes
    # size
    cpdef tuple get_size(RenderTextureWrapper self)
    cpdef csystem.Vector2u get_size_struct(RenderTextureWrapper self)
    cpdef tuple get_size_xy(RenderTextureWrapper self)
    # active
    cpdef set_active(RenderTextureWrapper self, bint active)
    # view
    cpdef ViewWrapper get_view(RenderTextureWrapper self)
    cpdef set_view(RenderTextureWrapper self, ViewWrapper view)
    # default_view
    cpdef ViewWrapper get_default_view(RenderTextureWrapper self)
    # texture
    cpdef TextureWrapper get_texture(RenderTextureWrapper self)
    # smooth
    cpdef bint is_smooth(RenderTextureWrapper self)
    cpdef set_smooth(RenderTextureWrapper self, bint smooth)
    # repeated
    cpdef bint is_repeated(RenderTextureWrapper self)
    cpdef set_repeated(RenderTextureWrapper self, bint repeated)


cdef class RenderTexture(RenderTextureWrapper):
    pass


cdef RenderTextureWrapper RenderTexture_wrap_ptr(cgraphics.RenderTexture* render_texture_ptr)
cdef RenderTexture RenderTexture_create(unsigned int width, unsigned int height, bint depth_buffer)


# RenderWindow
################################################################################

cdef class RenderWindowWrapper:
    cdef cgraphics.RenderWindow* RenderWindow
    # Cython methods
    cpdef close(RenderWindowWrapper self)
    cpdef display(RenderWindowWrapper self)
    cpdef destroy(RenderWindowWrapper self)
    # clear
    cpdef clear(RenderWindowWrapper self, color)
    cpdef clear_struct(RenderWindowWrapper self, cgraphics.Color color)
    cpdef clear_rgb(RenderWindowWrapper self, Uint8 r, Uint8 g, Uint8 b)
    cpdef clear_rgba(RenderWindowWrapper self, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    # get_viewport
    cpdef tuple get_viewport(RenderWindowWrapper self, ViewWrapper view)
    cpdef cgraphics.IntRect get_viewport_struct(RenderWindowWrapper self, ViewWrapper view)
    cpdef tuple get_viewport_ltwh(RenderWindowWrapper self, ViewWrapper view)
    # map_pixel_to_coords
    cpdef tuple map_pixel_to_coords(RenderWindowWrapper self, point, ViewWrapper view)
    cpdef csystem.Vector2f map_pixel_to_coords_struct(RenderWindowWrapper self, csystem.Vector2i point, ViewWrapper view)
    cpdef tuple map_pixel_to_coords_xy(RenderWindowWrapper self, int x, int y, ViewWrapper view)
    # map_coords_to_pixel
    cpdef tuple map_coords_to_pixel(RenderWindowWrapper self, point, ViewWrapper view)
    cpdef csystem.Vector2i map_coords_to_pixel_struct(RenderWindowWrapper self, csystem.Vector2f point, ViewWrapper view)
    cpdef tuple map_coords_to_pixel_xy(RenderWindowWrapper self, float x, float y, ViewWrapper view)
    # draw
    cpdef draw_sprite(RenderWindowWrapper self, SpriteWrapper sprite)
    cpdef draw_text(RenderWindowWrapper self, TextWrapper text)
    cpdef draw_shape(RenderWindowWrapper self, ShapeWrapper shape)
    cpdef draw_circle_shape(RenderWindowWrapper self, CircleShapeWrapper circle_shape)
    cpdef draw_convex_shape(RenderWindowWrapper self, ConvexShapeWrapper convex_shape)
    cpdef draw_rectangle_shape(RenderWindowWrapper self, RectangleShapeWrapper rectangle_shape)
    cpdef draw_vertex_array(RenderWindowWrapper self, VertexArrayWrapper vertex_array)
    #cpdef draw_vertex_array_states(RenderWindowWrapper self, VertexArrayWrapper vertex_array, RenderStates states)
    # TODO: vertices array
    #cpdef draw_primitives(RenderWindowWrapper self, Vertex vertices)
    # GL_states
    cpdef push_GL_states(RenderWindowWrapper self)
    cpdef pop_GL_states(RenderWindowWrapper self)
    cpdef reset_GL_states(RenderWindowWrapper self)
    # Attributes
    # open
    cpdef bint is_open(RenderWindowWrapper self)
    # settings
    cpdef cwindow.ContextSettings get_settings(RenderWindowWrapper self)
    # title
    cpdef set_title(RenderWindowWrapper self, const char* title)
    # TODO: set_unicode_title
    # TODO: set_icon
    # visible
    cpdef set_visible(RenderWindowWrapper self, bint visible)
    # size
    cpdef tuple get_size(RenderWindowWrapper self)
    cpdef csystem.Vector2u get_size_struct(RenderWindowWrapper self)
    cpdef tuple get_size_xy(RenderWindowWrapper self)
    cpdef set_size(RenderWindowWrapper self, size)
    cpdef set_size_struct(RenderWindowWrapper self, csystem.Vector2u size)
    cpdef set_size_xy(RenderWindowWrapper self, unsigned int x, unsigned int y)
    # width
    cpdef unsigned int get_width(RenderWindowWrapper self)
    cpdef set_width(RenderWindowWrapper self, unsigned int width)
    # height
    cpdef unsigned int get_height(RenderWindowWrapper self)
    cpdef set_height(RenderWindowWrapper self, unsigned int height)
    # active
    cpdef set_active(RenderWindowWrapper self, bint active)
    # view
    cpdef ViewWrapper get_view(RenderWindowWrapper self)
    cpdef set_view(RenderWindowWrapper self, ViewWrapper view)
    # default_view
    cpdef ViewWrapper get_default_view(RenderWindowWrapper self)
    # vsync
    cpdef set_vsync(RenderWindowWrapper self, bint vsync)
    # mouse_cursor_visible
    cpdef set_mouse_cursor_visible(RenderWindowWrapper self, bint visible)
    # repeat_key
    cpdef set_key_repeat(RenderWindowWrapper self, bint enabled)
    # framerate_limit
    cpdef set_framerate_limit(RenderWindowWrapper self, unsigned int limit)
    # joystick_threshold
    cpdef set_joystick_threshold(RenderWindowWrapper self, float threshold)


cdef class RenderWindow(RenderWindowWrapper):
    pass


cdef RenderWindowWrapper RenderWindow_create(
        window.VideoMode video_mode,
        const char* title,
        Uint32 style=*)
cdef RenderWindowWrapper RenderWindow_from_struct(
        cwindow.VideoMode video_mode,
        const char* title,
        Uint32 style=*)
cdef RenderWindowWrapper RenderWindow_wrap_ptr(cgraphics.RenderWindow* render_window_ptr)

