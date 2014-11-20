from config cimport (
    Uint8,
    Uint32,
)
from csystem cimport (
    InputStream,
    Vector2f,
    Vector2i,
    Vector2u,
    Vector3f,
)
from cwindow cimport (
    ContextSettings,
    Event,
    Window,
    VideoMode,
)


# SFML/Graphics/Types.h
################################################################################

cdef extern from 'SFML/Graphics/Types.h' nogil:
    ctypedef struct CircleShape 'sfCircleShape'
    ctypedef struct ConvexShape 'sfConvexShape'
    ctypedef struct Font 'sfFont'
    ctypedef struct Image 'sfImage'
    ctypedef struct Shader 'sfShader'
    ctypedef struct RectangleShape 'sfRectangleShape'
    ctypedef struct RenderTexture 'sfRenderTexture'
    ctypedef struct RenderWindow 'sfRenderWindow'
    ctypedef struct Shape 'sfShape'
    ctypedef struct Sprite 'sfSprite'
    ctypedef struct Text 'sfText'
    ctypedef struct Texture 'sfTexture'
    ctypedef struct Transformable 'sfTransformable'
    ctypedef struct VertexArray 'sfVertexArray'
    ctypedef struct View 'sfView'


# SFML/Graphics/PrimitiveType.h
################################################################################

cdef extern from 'SFML/Graphics/PrimitiveType.h' nogil:
    ctypedef enum PrimitiveType 'sfPrimitiveType':
        POINTS 'sfPoints'
        LINES 'sfLines'
        LINES_STRIP 'sfLinesStrip'
        TRIANGLES 'sfTriangles'
        TRIANGLES_STRIP 'sfTrianglesStrip'
        TRIANGLES_FAM 'sfTrianglesFan'
        QUADS 'sfQuads'


# SFML/Graphics/BlendMode.h
################################################################################

cdef extern from 'SFML/Graphics/BlendMode.h' nogil:
    ctypedef enum BlendMode 'sfBlendMode':
        BLEND_ALPHA 'sfBlendAlpha'
        BLEND_ADD 'sfBlendAdd'
        BLEND_MULTIPLY 'sfBlendMultiply'
        BLEND_NONE 'sfBlendNone'


# SFML/Graphics/Rect.h
################################################################################

cdef extern from 'SFML/Graphics/Rect.h' nogil:
    ctypedef struct FloatRect 'sfFloatRect':
        float left
        float top
        float width
        float height
    
    ctypedef struct IntRect 'sfIntRect':
        int left
        int top
        int width
        int height
    
    cdef bint FloatRect_contains 'sfFloatRect_contains' (const FloatRect* rect, float x, float y)
    cdef bint IntRect_contains 'sfIntRect_contains' (const IntRect* rect, int x, int y)
    cdef bint FloatRect_intersects 'sfFloatRect_intersects' (const FloatRect* rect1, const FloatRect* rect2, FloatRect* intersection)
    cdef bint IntRect_intersects 'sfIntRect_intersects' (const IntRect* rect1, const IntRect* rect2, IntRect* intersection)


# SFML/Graphics/View.h
################################################################################

cdef extern from 'SFML/Graphics/View.h' nogil:
    cdef View* View_create 'sfView_create' ()
    cdef View* View_create_from_rect 'sfView_createFromRect' (FloatRect)
    cdef View* View_copy 'sfView_copy' (const View* view)
    cdef void View_set_center 'sfView_setCenter' (View* view, Vector2f center)
    cdef void View_set_size 'sfView_setSize' (View* view, Vector2f size)
    cdef void View_set_rotation 'sfView_setRotation' (View* view, float angle)
    cdef void View_set_viewport 'sfView_setViewport' (View* view, FloatRect viewport)
    cdef void View_reset 'sfView_reset' (View* view, FloatRect rectangle)
    cdef Vector2f View_get_center 'sfView_getCenter' (const View* view)
    cdef Vector2f View_get_size 'sfView_getSize' (const View* view)
    cdef float View_get_rotation 'sfView_getRotation' (const View* view)
    cdef FloatRect View_get_viewport 'sfView_getViewport' (const View* view)
    cdef void View_move 'sfView_move' (const View* view, Vector2f offset)
    cdef void View_rotate 'sfView_rotate' (const View* view, float angle)
    cdef void View_zoom 'sfView_zoom' (View* view, float factor)


# SFML/Graphics/Color.h
################################################################################

cdef extern from 'SFML/Graphics/Color.h' nogil:
    ctypedef struct Color 'sfColor':
        unsigned int r
        unsigned int g
        unsigned int b
        unsigned int a
    
    cdef Color COLOR_BLACK 'sfBlack'
    cdef Color COLOR_WHITE 'sfWhite'
    cdef Color COLOR_RED 'sfRed'
    cdef Color COLOR_GREEN 'sfGreen'
    cdef Color COLOR_BLUE 'sfBlue'
    cdef Color COLOR_YELLOW 'sfYellow'
    cdef Color COLOR_MAGENTA 'sfMagenta'
    cdef Color COLOR_CYAN 'sfCyan'
    cdef Color COLOR_TRANSPARENT 'sfTransparent'
    cdef Color Color_from_rgb 'sfColor_fromRGB' (unsigned int red, unsigned int green, unsigned int blue)
    cdef Color Color_from_rgba 'sfColor_fromRGBA'(Uint8 red, Uint8 green, Uint8 blue, Uint8 alpha)
    cdef Color Color_add 'sfColor_add' (Color color1, Color color2)
    cdef Color Color_modulate 'sfColor_modulate' (Color color1, Color color2)


# SFML/Graphics/Vertex.h
################################################################################

cdef extern from 'SFML/Graphics/Vertex.h' nogil:
    ctypedef struct Vertex 'sfVertex':
        Vector2f position
        Color color
        Vector2f tex_coords 'texCoords'


# SFML/Graphics/VertexArray.h
################################################################################

cdef extern from 'SFML/Graphics/VertexArray.h' nogil:
    cdef VertexArray* VertexArray_create 'sfVertexArray_create' ()
    cdef VertexArray* VertexArray_copy 'sfVertexArray_copy' (const VertexArray* vertexArray)
    cdef void VertexArray_destroy 'sfVertexArray_destroy' (VertexArray* vertexArray)
    cdef unsigned int VertexArray_get_vertex_count 'sfVertexArray_getVertexCount' (const VertexArray* vertexArray)
    cdef Vertex* VertexArray_get_vertex 'sfVertexArray_getVertex' (VertexArray* vertexArray, unsigned int index)
    cdef void VertexArray_clear 'sfVertexArray_clear' (VertexArray* vertexArray)
    cdef void VertexArray_resize 'sfVertexArray_resize' (VertexArray* vertexArray, unsigned int vertexCount)
    cdef void VertexArray_append 'sfVertexArray_append' (VertexArray* vertexArray, Vertex vertex)
    cdef void VertexArray_set_primitive_type 'sfVertexArray_setPrimitiveType' (VertexArray* vertexArray, int type)#PrimitiveType type)
    cdef PrimitiveType VertexArray_get_primitive_type 'sfVertexArray_getPrimitiveType' (VertexArray* vertexArray)
    cdef FloatRect VertexArray_get_bounds 'sfVertexArray_getBounds' (VertexArray* vertexArray)


# SFML/Graphics/Glyph.h
################################################################################

cdef extern from 'SFML/Graphics/Glyph.h' nogil:
    ctypedef struct Glyph 'sfGlyph':
        int advance
        IntRect bounds
        IntRect texture_rect 'textureRect'


# SFML/Graphics/Transform.h
################################################################################

cdef extern from 'SFML/Graphics/Transform.h' nogil:
    ctypedef struct Transform 'sfTransform':
        float matrix[9]
    
    cdef const Transform TRANSFORM_IDENTITY 'sfTransform_Identity'
    
    cdef Transform Transform_from_matrix 'sfTransform_fromMatrix' (
        float a00, float a01, float a02,
        float a10, float a11, float a12,
        float a20, float a21, float a22,
    )
    cdef void Transform_get_matrix 'sfTransform_getMatrix' (const Transform* transform, float* matrix)
    cdef Transform Transform_get_inverse 'sfTransform_getInverse' (const Transform* transform)
    cdef FloatRect Transform_transform_rect 'sfTransform_transformRect' (const Transform* transform, FloatRect rectangle)
    cdef void Transform_combine 'sfTransform_combine' (Transform* transform, const Transform* other)
    cdef void Transform_translate 'sfTransform_translate' (Transform* transform, float x, float y)
    cdef void Transform_rotate 'sfTransform_rotate' (Transform* transform, float angle)
    cdef void Transform_rotate_with_center 'sfTransform_rotateWithCenter' (Transform* transform, float angle, float centerX, float centerY)
    cdef void Transform_scale 'sfTransform_scale' (Transform* transform, float scaleX, float scaleY)
    cdef void Transform_scale_with_center 'sfTransform_scaleWithCenter' (Transform* transform, float scaleX, float scaleY, float centerX, float centerY)


# SFML/Graphics/Transformable.h
################################################################################

cdef extern from 'SFML/Graphics/Transformable.h' nogil:
    cdef Transformable* Transformable_create 'sfTransformable_create' ()
    cdef Transformable* Transformable_copy 'sfTransformable_copy' (Transformable* transformable)
    cdef void Transformable_destroy 'sfTransformable_destroy' (Transformable* transformable)
    cdef void Transformable_set_position 'sfTransformable_setPosition' (Transformable* transformable, Vector2f position)
    cdef void Transformable_set_rotation 'sfTransformable_setRotation' (Transformable* transformable, float angle)
    cdef void Transformable_set_scale 'sfTransformable_setScale' (Transformable* transformable, Vector2f scale)
    cdef void Transformable_set_origin 'sfTransformable_setOrigin' (Transformable* transformable, Vector2f origin)
    cdef Vector2f Transformable_get_position 'sfTransformable_getPosition' (const Transformable* transformable)
    cdef float Transformable_get_rotation 'sfTransformable_getRotation' (const Transformable* transformable)
    cdef Vector2f Transformable_get_scale 'sfTransformable_getScale' (const Transformable* transformable)
    cdef Vector2f Transformable_get_origin 'sfTransformable_getOrigin' (const Transformable* transformable)
    cdef void Transformable_move 'sfTransformable_move' (Transformable* transformable, Vector2f offset)
    cdef void Transformable_rotate 'sfTransformable_rotate' (Transformable* transformable, float angle)
    cdef void Transformable_scale 'sfTransformable_scale' (Transformable* transformable, Vector2f scale)
    cdef Transform Transformable_get_transform 'sfTransformable_getTransform' (Transformable* transformable)
    cdef Transform Transformable_get_inverse_transform 'sfTransformable_getInverseTransform' (Transformable* transformable)


# SFML/Graphics/Shape.h
################################################################################

cdef extern from 'SFML/Graphics/Shape.h' nogil:
    ctypedef unsigned int (*ShapeGetPointCountCallback 'sfShapeGetPointCountCallback')(void*)
    ctypedef Vector2f (*ShapeGetPointCallback 'sfShapeGetPointCallback')(unsigned int, void*)
    
    cdef Shape* Shape_create (ShapeGetPointCountCallback getPointCount, ShapeGetPointCallback getPoint, void* userData)
    cdef void Shape_destroy 'sfShape_destroy' (Shape* shape)
    cdef void Shape_set_position 'sfShape_setPosition' (Shape* shape, Vector2f position)
    cdef void Shape_set_rotation 'sfShape_setRotation' (Shape* shape, float angle)
    cdef void Shape_set_scale 'sfShape_setScale' (Shape* shape, Vector2f scale)
    cdef void Shape_set_origin 'sfShape_setOrigin' (Shape* shape, Vector2f origin)
    cdef Vector2f Shape_get_position 'sfShape_getPosition' (const Shape* shape)
    cdef float Shape_get_rotation 'sfShape_getRotation' (const Shape* shape)
    cdef Vector2f Shape_get_scale 'sfShape_getScale' (const Shape* shape)
    cdef Vector2f Shape_get_origin 'sfShape_getOrigin' (const Shape* shape)
    cdef void Shape_move 'sfShape_move' (Shape* shape, Vector2f move)
    cdef void Shape_rotate 'sfShape_rotate' (Shape* shape, float angle)
    cdef void Shape_scale 'sfShape_scale' (Shape* shape, Vector2f factors)
    cdef Transform Shape_get_transform 'sfShape_getTransform' (Shape* shape)
    cdef Transform Shape_get_inverse_transform 'sfShape_getInverseTransform' (Shape* shape)
    cdef void Shape_set_texture 'sfShape_setTexture' (Shape* shape, Texture* texture, bint resetRect)
    cdef void Shape_set_texture_rect 'sfShape_setTextureRect' (Shape* shape, IntRect rect)
    cdef void Shape_set_fill_color 'sfShape_setFillColor' (Shape* shape, Color color)
    cdef void Shape_set_outline_color 'sfShape_setOutlineColor' (Shape* shape, Color color)
    cdef void Shape_set_outline_thickness 'sfShape_setOutlineThickness' (Shape* shape, float thickness)
    cdef const Texture* Shape_get_texture 'sfShape_getTexture' (const Shape* shape)
    cdef IntRect Shape_get_texture_rect 'sfShape_getTextureRect' (const Shape* shape)
    cdef Color Shape_get_fill_color 'sfShape_getFillColor' (const Shape* shape)
    cdef Color Shape_get_outline_color 'sfShape_getOutlineColor' (const Shape* shape)
    cdef float Shape_get_outline_thickness 'sfShape_getOutlineThickness' (const Shape* shape)
    cdef unsigned int Shape_get_point_count 'sfShape_getPointCount' (const Shape* shape)
    cdef Vector2f Shape_get_point 'sfShape_getPoint' (const Shape* shape, unsigned int index)
    cdef FloatRect Shape_get_local_bounds 'sfShape_getLocalBounds' (const Shape* shape)
    cdef FloatRect Shape_get_global_bounds 'sfShape_getGlobalBounds' (const Shape* shape)
    cdef void Shape_update 'sfShape_update' (const Shape* shape)


# SFML/Graphics/CircleShape.h
################################################################################

cdef extern from 'SFML/Graphics/CircleShape.h' nogil:
    cdef CircleShape* CircleShape_create 'sfCircleShape_create' ()
    cdef CircleShape* CircleShape_copy 'sfCircleShape_copy' (CircleShape* shape)
    cdef void CircleShape_destroy 'sfCircleShape_destroy' (CircleShape* shape)
    cdef void CircleShape_set_position 'sfCircleShape_setPosition' (CircleShape* shape, Vector2f position)
    cdef void CircleShape_set_rotation 'sfCircleShape_setRotation' (CircleShape* shape, float angle)
    cdef void CircleShape_set_scale 'sfCircleShape_setScale' (CircleShape* shape, Vector2f scale)
    cdef void CircleShape_set_origin 'sfCircleShape_setOrigin' (CircleShape* shape, Vector2f origin)
    cdef Vector2f CircleShape_get_position 'sfCircleShape_getPosition' (const CircleShape* shape)
    cdef float CircleShape_get_rotation 'sfCircleShape_getRotation' (const CircleShape* shape)
    cdef Vector2f CircleShape_get_scale 'sfCircleShape_getScale' (const CircleShape* shape)
    cdef Vector2f CircleShape_get_origin 'sfCircleShape_getOrigin' (const CircleShape* shape)
    cdef void CircleShape_move 'sfCircleShape_move' (CircleShape* shape, Vector2f offset)
    cdef void CircleShape_rotate 'sfCircleShape_rotate' (CircleShape* shape, float angle)
    cdef void CircleShape_scale 'sfCircleShape_scale' (CircleShape* shape, Vector2f scale)
    cdef Transform CircleShape_get_transform 'sfCircleShape_getTransform' (const CircleShape* shape)
    cdef Transform CircleShape_get_inverse_transform 'sfCircleShape_getInverseTransform' (const CircleShape* shape)
    cdef void CircleShape_set_texture 'sfCircleShape_setTexture' (CircleShape* shape, const Texture* texture, bint resetRect)
    cdef void CircleShape_set_texture_rect 'sfCircleShape_setTextureRect' (CircleShape* shape, IntRect rect)
    cdef void CircleShape_set_fill_color 'sfCircleShape_setFillColor' (CircleShape* shape, Color color)
    cdef void CircleShape_set_outline_color 'sfCircleShape_setOutlineColor' (CircleShape* shape, Color color)
    cdef void CircleShape_set_outline_thickness 'sfCircleShape_setOutlineThickness' (CircleShape* shape, float thickness)
    cdef const Texture* CircleShape_get_texture 'sfCircleShape_getTexture' (CircleShape* shape)
    cdef IntRect CircleShape_get_texture_rect 'sfCircleShape_getTextureRect' (CircleShape* shape)
    cdef Color CircleShape_get_fill_color 'sfCircleShape_getFillColor' (CircleShape* shape)
    cdef Color CircleShape_get_outline_color 'sfCircleShape_getOutlineColor' (CircleShape* shape)
    cdef float CircleShape_get_outline_thickness 'sfCircleShape_getOutlineThickness' (CircleShape* shape)
    cdef unsigned int CircleShape_get_point_count 'sfCircleShape_getPointCount' (const CircleShape* shape)
    cdef Vector2f CircleShape_get_point 'sfCircleShape_getPoint' (const CircleShape* shape, unsigned int index)
    cdef void CircleShape_set_radius 'sfCircleShape_setRadius' (CircleShape* shape, float radius)
    cdef float CircleShape_get_radius 'sfCircleShape_getRadius' (const CircleShape* shape)
    cdef void CircleShape_set_point_count 'sfCircleShape_setPointCount' (CircleShape* shape, unsigned int count)
    cdef FloatRect CircleShape_get_local_bounds 'sfCircleShape_getLocalBounds' (CircleShape* shape)
    cdef FloatRect CircleShape_get_global_bounds 'sfCircleShape_getGlobalBounds' (CircleShape* shape)
    

# SFML/Graphics/RectangleShape.h
################################################################################

cdef extern from 'SFML/Graphics/RectangleShape.h' nogil:
    cdef RectangleShape* RectangleShape_create 'sfRectangleShape_create' ()
    cdef RectangleShape* RectangleShape_copy 'sfRectangleShape_copy' (RectangleShape* shape)
    cdef void RectangleShape_destroy 'sfRectangleShape_destroy' (RectangleShape* shape)
    cdef void RectangleShape_set_position 'sfRectangleShape_setPosition' (RectangleShape* shape, Vector2f position)
    cdef void RectangleShape_set_rotation 'sfRectangleShape_setRotation' (RectangleShape* shape, float angle)
    cdef void RectangleShape_set_scale 'sfRectangleShape_setScale' (RectangleShape* shape, Vector2f scale)
    cdef void RectangleShape_set_origin 'sfRectangleShape_setOrigin' (RectangleShape* shape, Vector2f origin)
    cdef Vector2f RectangleShape_get_position 'sfRectangleShape_getPosition' (const RectangleShape* shape)
    cdef float RectangleShape_get_rotation 'sfRectangleShape_getRotation' (const RectangleShape* shape)
    cdef Vector2f RectangleShape_get_scale 'sfRectangleShape_getScale' (const RectangleShape* shape)
    cdef Vector2f RectangleShape_get_origin 'sfRectangleShape_getOrigin' (const RectangleShape* shape)
    cdef void RectangleShape_move 'sfRectangleShape_move' (RectangleShape* shape, Vector2f offset)
    cdef void RectangleShape_rotate 'sfRectangleShape_rotate' (RectangleShape* shape, float angle)
    cdef void RectangleShape_scale 'sfRectangleShape_scale' (RectangleShape* shape, Vector2f scale)
    cdef Transform RectangleShape_get_transform 'sfRectangleShape_getTransform' (const RectangleShape* shape)
    cdef Transform RectangleShape_get_inverse_transform 'sfRectangleShape_getInverseTransform' (const RectangleShape* shape)
    cdef void RectangleShape_set_texture 'sfRectangleShape_setTexture' (RectangleShape* shape, const Texture* texture, bint resetRect)
    cdef void RectangleShape_set_texture_rect 'sfRectangleShape_setTextureRect' (RectangleShape* shape, IntRect rect)
    cdef void RectangleShape_set_fill_color 'sfRectangleShape_setFillColor' (RectangleShape* shape, Color color)
    cdef void RectangleShape_set_outline_color 'sfRectangleShape_setOutlineColor' (RectangleShape* shape, Color color)
    cdef void RectangleShape_set_outline_thickness 'sfRectangleShape_setOutlineThickness' (RectangleShape* shape, float thickness)
    cdef const Texture* RectangleShape_get_texture 'sfRectangleShape_getTexture' (RectangleShape* shape)
    cdef IntRect RectangleShape_get_texture_rect 'sfRectangleShape_getTextureRect' (RectangleShape* shape)
    cdef Color RectangleShape_get_fill_color 'sfRectangleShape_getFillColor' (RectangleShape* shape)
    cdef Color RectangleShape_get_outline_color 'sfRectangleShape_getOutlineColor' (RectangleShape* shape)
    cdef float RectangleShape_get_outline_thickness 'sfRectangleShape_getOutlineThickness' (RectangleShape* shape)
    cdef unsigned int RectangleShape_get_point_count 'sfRectangleShape_getPointCount' (const RectangleShape* shape)
    cdef Vector2f RectangleShape_get_point 'sfRectangleShape_getPoint' (const RectangleShape* shape, unsigned int index)
    cdef void RectangleShape_set_size 'sfRectangleShape_setSize' (RectangleShape* shape, Vector2f size)
    cdef Vector2f RectangleShape_get_size 'sfRectangleShape_getSize' (const RectangleShape* shape)
    cdef FloatRect RectangleShape_get_local_bounds 'sfRectangleShape_getLocalBounds' (RectangleShape* shape)
    cdef FloatRect RectangleShape_get_global_bounds 'sfRectangleShape_getGlobalBounds' (RectangleShape* shape)


# SFML/Graphics/ConvexShape.h
################################################################################

cdef extern from 'SFML/Graphics/ConvexShape.h' nogil:
    cdef ConvexShape* ConvexShape_create 'sfConvexShape_create' ()
    cdef ConvexShape* ConvexShape_copy 'sfConvexShape_copy' (ConvexShape* shape)
    cdef void ConvexShape_destroy 'sfConvexShape_destroy' (ConvexShape* shape)
    cdef void ConvexShape_set_position 'sfConvexShape_setPosition' (ConvexShape* shape, Vector2f position)
    cdef void ConvexShape_set_rotation 'sfConvexShape_setRotation' (ConvexShape* shape, float angle)
    cdef void ConvexShape_set_scale 'sfConvexShape_setScale' (ConvexShape* shape, Vector2f scale)
    cdef void ConvexShape_set_origin 'sfConvexShape_setOrigin' (ConvexShape* shape, Vector2f origin)
    cdef Vector2f ConvexShape_get_position 'sfConvexShape_getPosition' (const ConvexShape* shape)
    cdef float ConvexShape_get_rotation 'sfConvexShape_getRotation' (const ConvexShape* shape)
    cdef Vector2f ConvexShape_get_scale 'sfConvexShape_getScale' (const ConvexShape* shape)
    cdef Vector2f ConvexShape_get_origin 'sfConvexShape_getOrigin' (const ConvexShape* shape)
    cdef void ConvexShape_move 'sfConvexShape_move' (ConvexShape* shape, Vector2f offset)
    cdef void ConvexShape_rotate 'sfConvexShape_rotate' (ConvexShape* shape, float angle)
    cdef void ConvexShape_scale 'sfConvexShape_scale' (ConvexShape* shape, Vector2f scale)
    cdef Transform ConvexShape_get_transform 'sfConvexShape_getTransform' (const ConvexShape* shape)
    cdef Transform ConvexShape_get_inverse_transform 'sfConvexShape_getInverseTransform' (const ConvexShape* shape)
    cdef void ConvexShape_set_texture 'sfConvexShape_setTexture' (ConvexShape* shape, const Texture* texture, bint resetRect)
    cdef void ConvexShape_set_texture_rect 'sfConvexShape_setTextureRect' (ConvexShape* shape, IntRect rect)
    cdef void ConvexShape_set_fill_color 'sfConvexShape_setFillColor' (ConvexShape* shape, Color color)
    cdef void ConvexShape_set_outline_color 'sfConvexShape_setOutlineColor' (ConvexShape* shape, Color color)
    cdef void ConvexShape_set_outline_thickness 'sfConvexShape_setOutlineThickness' (ConvexShape* shape, float thickness)
    cdef const Texture* ConvexShape_get_texture 'sfConvexShape_getTexture' (ConvexShape* shape)
    cdef IntRect ConvexShape_get_texture_rect 'sfConvexShape_getTextureRect' (ConvexShape* shape)
    cdef Color ConvexShape_get_fill_color 'sfConvexShape_getFillColor' (ConvexShape* shape)
    cdef Color ConvexShape_get_outline_color 'sfConvexShape_getOutlineColor' (ConvexShape* shape)
    cdef float ConvexShape_get_outline_thickness 'sfConvexShape_getOutlineThickness' (ConvexShape* shape)
    cdef unsigned int ConvexShape_get_point_count 'sfConvexShape_getPointCount' (const ConvexShape* shape)
    cdef Vector2f ConvexShape_get_point 'sfConvexShape_getPoint' (const ConvexShape* shape, unsigned int index)
    cdef void ConvexShape_set_point_count 'sfConvexShape_setPointCount' (const ConvexShape* shape, unsigned int count)
    cdef void ConvexShape_set_point 'sfConvexShape_setPoint' (const ConvexShape* shape, unsigned int index, Vector2f point)
    cdef FloatRect ConvexShape_get_local_bounds 'sfConvexShape_getLocalBounds' (ConvexShape* shape)
    cdef FloatRect ConvexShape_get_global_bounds 'sfConvexShape_getGlobalBounds' (ConvexShape* shape)


# SFML/Graphics/Font.h
################################################################################

cdef extern from 'SFML/Graphics/Font.h' nogil:
    cdef Font* Font_create_from_file 'sfFont_createFromFile' (const char* filename)
    cdef Font* Font_create_from_memory 'sfFont_createFromMemory' (const void* data, size_t sizeInBytes)
    cdef Font* Font_create_from_stream 'sfFont_createFromStream' (InputStream* stream)
    cdef Font* Font_copy 'sfFont_copy' (Font* font)
    cdef Font* Font_destroy 'sfFont_destroy' (Font* font)
    cdef Glyph Font_get_glyph 'sfFont_getGlyph' (Font* font, Uint32 codePoint, unsigned int characterSize, bint bold)
    cdef int Font_get_kerning 'sfFont_getKerning' (Font* font, Uint32 first, Uint32 second, unsigned int characterSize)
    cdef int Font_get_line_spacing 'sfFont_getLineSpacing' (Font* font, unsigned int characterSize)
    cdef const Texture* Font_get_texture 'sfFont_getTexture' (Font* font, unsigned int characterSize)


# SFML/Graphics/Image.h
################################################################################

cdef extern from 'SFML/Graphics/Image.h' nogil:
    cdef Image* Image_create 'sfImage_create' (unsigned int width, unsigned int height)
    cdef Image* Image_create_from_color 'sfImage_createFromColor' (unsigned int width, unsigned int height, Color color)
    cdef Image* Image_create_from_pixels 'sfImage_createFromPixels' (unsigned int width, unsigned int height, const Uint8* pixels)
    cdef Image* Image_create_from_file 'sfImage_createFromFile' (const char* filename)
    cdef Image* Image_create_from_memory 'sfImage_createFromMemory' (const void* data, size_t size)
    cdef Image* Image_create_from_stream 'sfImage_createFromStream' (InputStream* stream)
    cdef Image* Image_copy 'sfImage_copy' (const Image* image)
    cdef void Image_destroy 'sfImage_destroy' (const Image* image)
    cdef bint Image_save_to_file 'sfImage_saveToFile' (const Image* image, const char* filename)
    cdef Vector2u Image_get_size 'sfImage_getSize' (const Image* image)
    cdef void Image_create_mask_from_color 'sfImage_createMaskFromColor' (Image* image, Color color, Uint8 alpha)
    cdef void Image_copy_image 'sfImage_copyImage' (Image* image, const Image* source, unsigned int destX, unsigned int destY, IntRect source_rect, bint applyAlpha)
    cdef void Image_set_pixel 'sfImage_setPixel' (Image* image, unsigned int x, unsigned int y, Color color)
    cdef Color Image_get_pixel 'sfImage_getPixel' (Image* image, unsigned int x, unsigned int y)
    cdef const Uint8* Image_get_pixels_ptr 'sfImage_getPixelsPtr' (const Image* image)
    cdef void Image_flip_horizontally 'sfImage_flipHorizontally' (Image* image)
    cdef void Image_flip_vertically 'sfImage_flipVertically' (Image* image)


# SFML/Graphics/Sprite.h
################################################################################

cdef extern from 'SFML/Graphics/Sprite.h' nogil:
    cdef Sprite* Sprite_create 'sfSprite_create' ()
    cdef Sprite* Sprite_copy 'sfSprite_copy' (Sprite* sprite)
    cdef void Sprite_destroy 'sfSprite_destroy' (Sprite* sprite)
    cdef void Sprite_set_position 'sfSprite_setPosition' (Sprite* sprite, Vector2f position)
    cdef void Sprite_set_rotation 'sfSprite_setRotation' (Sprite* sprite, float angle)
    cdef void Sprite_set_scale 'sfSprite_setScale' (Sprite* sprite, Vector2f scale)
    cdef void Sprite_set_origin 'sfSprite_setOrigin' (Sprite* sprite, Vector2f origin)
    cdef Vector2f Sprite_get_position 'sfSprite_getPosition' (Sprite* sprite)
    cdef float Sprite_get_rotation 'sfSprite_getRotation' (Sprite* sprite)
    cdef Vector2f Sprite_get_scale 'sfSprite_getScale' (Sprite* sprite)
    cdef Vector2f Sprite_get_origin 'sfSprite_getOrigin' (Sprite* sprite)
    cdef void Sprite_move 'sfSprite_move' (Sprite* sprite, Vector2f offset)
    cdef void Sprite_rotate 'sfSprite_rotate' (Sprite* sprite, float angle)
    cdef void Sprite_scale 'sfSprite_scale' (Sprite* sprite, Vector2f factors)
    cdef Transform Sprite_get_transform 'sfSprite_getTransform' (Sprite* sprite)
    cdef Transform Sprite_get_inverse_transform 'sfSprite_getInverseTransform' (Sprite* sprite)
    cdef void Sprite_set_texture 'sfSprite_setTexture' (Sprite* sprite, Texture* texture, bint resetRect)
    cdef void Sprite_set_texture_rect 'sfSprite_setTextureRect' (Sprite* sprite, IntRect rectangle)
    cdef void Sprite_set_color 'sfSprite_setColor' (Sprite* sprite, Color color)
    cdef const Texture* Sprite_get_texture 'sfSprite_getTexture' (Sprite* sprite)
    cdef IntRect Sprite_get_texture_rect 'sfSprite_getTextureRect' (Sprite* sprite)
    cdef Color Sprite_get_color 'sfSprite_getColor' (Sprite* sprite)
    cdef FloatRect Sprite_get_local_bounds 'sfSprite_getLocalBounds' (Sprite* sprite)
    cdef FloatRect Sprite_get_global_bounds 'sfSprite_getGlobalBounds' (Sprite* sprite)


# SFML/Graphics/RenderStates.h
################################################################################

cdef extern from 'SFML/Graphics/RenderStates.h' nogil:
    ctypedef struct RenderStates 'sfRenderStates':
        BlendMode blend_mode 'blendMode'
        Transform transform
        const Texture* texture
        const Shader* shader


# SFML/Graphics/Texture.h
################################################################################

cdef extern from 'SFML/Graphics/Texture.h' nogil:
    cdef Texture* Texture_create 'sfTexture_create' (unsigned int width, unsigned int height)
    cdef Texture* Texture_create_from_file 'sfTexture_createFromFile' (const char* filename, const IntRect* area)
    cdef Texture* Texture_create_from_memory 'sfTexture_createFromMemory' (const void* data, size_t sizeInBytes, const IntRect* area)
    cdef Texture* Texture_create_from_stream 'sfTexture_createFromStream' (InputStream* stream, IntRect* area)
    cdef Texture* Texture_create_from_image 'sfTexture_createFromImage' (const Image* image, const IntRect* area)
    cdef Texture* Texture_copy 'sfTexture_copy' (const Texture* texture)
    cdef void Texture_destroy 'sfTexture_destroy' (Texture* texture)
    cdef Vector2u Texture_get_size 'sfTexture_getSize' (const Texture* texture)
    cdef Image* Texture_copy_to_image 'sfTexture_copyToImage' (const Texture* texture)
    cdef void Texture_update_from_pixels 'sfTexture_updateFromPixels' (Texture* texture, const Uint8* pixels, unsigned int width, unsigned int height, unsigned int x, unsigned int y)
    cdef void Texture_update_from_image 'sfTexture_updateFromImage' (Texture* texture, const Image* image, unsigned int x, unsigned int y)
    cdef void Texture_update_from_window 'sfTexture_updateFromWindow' (Texture* texture, const Window* window, unsigned int x, unsigned int y)
    cdef void Texture_update_from_render_window 'sfTexture_updateFromRenderWindow' (Texture* texture, const RenderWindow* renderWindow, unsigned int x, unsigned int y)
    cdef void Texture_set_smooth 'sfTexture_setSmooth' (Texture* texture, bint smooth)
    cdef bint Texture_is_smooth 'sfTexture_isSmooth' (const Texture* texture)
    cdef void Texture_set_repeated 'sfTexture_setRepeated' (Texture* texture, bint repeated)
    cdef bint Texture_is_repeated 'sfTexture_isRepeated' (Texture* texture)
    cdef void Texture_bind 'sfTexture_bind' (Texture* texture)
    
    cdef unsigned int Texture_get_maximum_size 'sfTexture_getMaximumSize' ()


# SFML/Graphics/RenderTexture.h
################################################################################

cdef extern from 'SFML/Graphics/RenderTexture.h' nogil:
    cdef RenderTexture* RenderTexture_create 'sfRenderTexture_create' (unsigned int width, unsigned int height, bint depthBuffer)
    cdef void RenderTexture_destroy 'sfRenderTexture_destroy' (RenderTexture* renderTexture)
    cdef Vector2u RenderTexture_get_size 'sfRenderTexture_getSize' (const RenderTexture* renderTexture)
    cdef bint RenderTexture_set_active 'sfRenderTexture_setActive' (RenderTexture* renderTexture, bint active)
    cdef void RenderTexture_display 'sfRenderTexture_display' (RenderTexture* renderTexture)
    cdef void RenderTexture_clear 'sfRenderTexture_clear' (RenderTexture* renderTexture, Color color)
    cdef void RenderTexture_set_view 'sfRenderTexture_setView' (RenderTexture* renderTexture, View* view)
    cdef const View* RenderTexture_get_view 'sfRenderTexture_getView' (RenderTexture* renderTexture)
    cdef const View* RenderTexture_get_default_view 'sfRenderTexture_getDefaultView' (const RenderTexture* renderTexture)
    cdef IntRect RenderTexture_get_viewport 'sfRenderTexture_getViewport' (const RenderTexture* renderTexture, const View* view)
    cdef Vector2f RenderTexture_map_pixel_to_coords 'sfRenderTexture_mapPixelToCoords' (const RenderTexture* renderTexture, Vector2i point, const View* view)
    cdef Vector2i RenderTexture_map_coords_to_pixel 'sfRenderTexture_mapCoordsToPixel' (const RenderTexture* renderTexture, Vector2f point, const View* view)
    cdef void RenderTexture_draw_sprite 'sfRenderTexture_drawSprite' (RenderTexture* renderTexture, const Sprite* object, const RenderStates* states)
    cdef void RenderTexture_draw_text 'sfRenderTexture_drawText' (RenderTexture* renderTexture, const Text* object, const RenderStates* states)
    cdef void RenderTexture_draw_shape 'sfRenderTexture_drawShape' (RenderTexture* renderTexture, const Shape* object, const RenderStates* states)
    cdef void RenderTexture_draw_circle_shape 'sfRenderTexture_drawCircleShape' (RenderTexture* renderTexture, const CircleShape* object, const RenderStates* states)
    cdef void RenderTexture_draw_convex_shape 'sfRenderTexture_drawConvexShape' (RenderTexture* renderTexture, const ConvexShape* object, const RenderStates* states)
    cdef void RenderTexture_draw_rectangle_shape 'sfRenderTexture_drawRectangleShape' (RenderTexture* renderTexture, const RectangleShape* object, const RenderStates* states)
    cdef void RenderTexture_draw_vertex_array 'sfRenderTexture_drawVertexArray' (RenderTexture* renderTexture, const VertexArray* object, const RenderStates* states)
    cdef void RenderTexture_draw_primitives 'sfRenderTexture_drawPrimitives' (RenderTexture* renderTexture, const Vertex* vertices, unsigned int vertexCount, PrimitiveType type, RenderStates* states)
    cdef void RenderTexture_push_GL_states 'sfRenderTexture_pushGLStates' (RenderTexture* renderTexture)    
    cdef void RenderTexture_pop_GL_states 'sfRenderTexture_popGLStates' (RenderTexture* renderTexture)
    cdef void RenderTexture_reset_GL_states 'sfRenderTexture_resetGLStates' (RenderTexture* renderTexture)
    cdef const Texture* RenderTexture_get_texture 'sfRenderTexture_getTexture' (const RenderTexture* renderTexture)
    cdef void RenderTexture_set_smooth 'sfRenderTexture_setSmooth' (RenderTexture* renderTexture, bint smooth)
    cdef bint RenderTexture_is_smooth 'sfRenderTexture_isSmooth' (const RenderTexture* renderTexture)
    cdef void RenderTexture_set_repeated 'sfRenderTexture_setRepeated' (RenderTexture* renderTexture, bint repeated)
    cdef bint RenderTexture_is_repeated 'sfRenderTexture_isRepeated' (const RenderTexture* renderTexture)


# SFML/Graphics/RenderWindow.h
################################################################################

cdef extern from 'SFML/Graphics/RenderWindow.h' nogil:
    cdef RenderWindow* RenderWindow_create 'sfRenderWindow_create' (VideoMode mode, const char* title, Uint32 style, const ContextSettings* settings)
    # TODO: createUnicode
    # TODO: createFromHandle
    cdef void RenderWindow_close 'sfRenderWindow_close' (RenderWindow* window)
    cdef void RenderWindow_destroy 'sfRenderWindow_destroy' (RenderWindow* window)
    cdef bint RenderWindow_is_open 'sfRenderWindow_isOpen' (const RenderWindow* window)
    cdef ContextSettings RenderWindow_get_settings 'sfRenderWindow_getSettings' (const RenderWindow* window)
    cdef bint RenderWindow_poll_event 'sfRenderWindow_pollEvent' (const RenderWindow* window, Event* event)
    cdef bint RenderWindow_wait_event 'sfRenderWindow_waitEvent' (const RenderWindow* window, Event* event)
    cdef Vector2i RenderWindow_get_position 'sfRenderWindow_getPosition' (const RenderWindow* window)
    cdef void RenderWindow_set_position 'sfRenderWindow_setPosition' (RenderWindow* window, Vector2i position)
    cdef Vector2u RenderWindow_get_size 'sfRenderWindow_getSize' (RenderWindow* window)
    cdef void RenderWindow_set_size 'sfRenderWindow_setSize' (RenderWindow* window, Vector2u size)
    cdef void RenderWindow_set_title 'sfRenderWindow_setTitle' (RenderWindow* window, const char* title)
    cdef void RenderWindow_set_unicode_title 'sfRenderWindow_setUnicodeTitle' (RenderWindow* window, Uint32* title)
    cdef void RenderWindow_set_icon 'sfRenderWindow_setIcon' (RenderWindow* window, unsigned int width, unsigned int height, const unsigned char* pixels)
    cdef void RenderWindow_set_visible 'sfRenderWindow_setVisible' (RenderWindow* window, bint visible)
    cdef void RenderWindow_set_vertical_sync_enabled 'sfRenderWindow_setVerticalSyncEnabled' (RenderWindow* window, bint enabled)
    cdef void RenderWindow_set_mouse_cursor_visible 'sfRenderWindow_setMouseCursorVisible' (RenderWindow* window, bint visible)
    cdef void RenderWindow_set_key_repeat_enabled 'sfRenderWindow_setKeyRepeatEnabled' (RenderWindow* window, bint enabled)
    cdef bint RenderWindow_set_active 'sfRenderWindow_setActive' (RenderWindow* window, bint active)
    cdef void RenderWindow_display 'sfRenderWindow_display' (RenderWindow* window)
    cdef void RenderWindow_set_framerate_limit 'sfRenderWindow_setFramerateLimit' (RenderWindow* window, unsigned int limit)
    cdef void RenderWindow_set_joystick_threshold 'sfRenderWindow_setJoystickThreshold' (RenderWindow* window, float threshold)
    cdef void RenderWindow_clear 'sfRenderWindow_clear' (RenderWindow* window, Color color)
    cdef void RenderWindow_set_view 'sfRenderWindow_setView' (RenderWindow* window, const View* view)
    cdef const View* RenderWindow_get_view 'sfRenderWindow_getView' (const RenderWindow* window)
    cdef const View* RenderWindow_get_default_view 'sfRenderWindow_getDefaultView' (const RenderWindow* window)
    cdef IntRect RenderWindow_get_viewport 'sfRenderWindow_getViewport' (const RenderWindow* renderWindow, const View* view)
    cdef Vector2f RenderWindow_map_pixel_to_coords 'sfRenderWindow_mapPixelToCoords' (const RenderWindow* renderWindow, Vector2i point, const View* view)
    cdef Vector2i RenderWindow_map_coords_to_pixel 'sfRenderWindow_mapCoordsToPixel' (const RenderWindow* renderWindow, Vector2f point, const View* view)
    cdef void RenderWindow_draw_sprite 'sfRenderWindow_drawSprite' (RenderWindow* renderWindow, const Sprite* object, const RenderStates* states)
    cdef void RenderWindow_draw_text 'sfRenderWindow_drawText' (RenderWindow* renderWindow, const Text* object, const RenderStates* states)
    cdef void RenderWindow_draw_shape 'sfRenderWindow_drawShape' (RenderWindow* renderWindow, const Shape* object, const RenderStates* states)
    cdef void RenderWindow_draw_circle_shape 'sfRenderWindow_drawCircleShape' (RenderWindow* renderWindow, const CircleShape* object, const RenderStates* states)
    cdef void RenderWindow_draw_convex_shape 'sfRenderWindow_drawConvexShape' (RenderWindow* renderWindow, const ConvexShape* object, const RenderStates* states)
    cdef void RenderWindow_draw_rectangle_shape 'sfRenderWindow_drawRectangleShape' (RenderWindow* renderWindow, const RectangleShape* object, const RenderStates* states)
    cdef void RenderWindow_draw_vertex_array 'sfRenderWindow_drawVertexArray' (RenderWindow* renderWindow, const VertexArray* object, const RenderStates* states)
    cdef void RenderWindow_draw_primitives 'sfRenderWindow_drawPrimitives' (RenderWindow* renderWindow, const Vertex* vertices, unsigned int vertexCount, PrimitiveType type, RenderStates* states)
    cdef void RenderWindow_push_GL_states 'sfRenderWindow_pushGLStates' (RenderWindow* renderWindow)
    cdef void RenderWindow_pop_GL_states 'sfRenderWindow_popGLStates' (RenderWindow* renderWindow)
    cdef void RenderWindow_reset_GL_states 'sfRenderWindow_resetGLStates' (RenderWindow* renderWindow)
    cdef Image* RenderWindow_capture 'sfRenderWindow_capture' (const RenderWindow* renderWindow)
    cdef Vector2i Mouse_get_position_render_window 'sfRenderWindow_getPositionRenderWindow' (const RenderWindow* relativeTo)
    cdef void Mouse_set_position_render_window 'sfRenderWindow_setPositionRenderWindow' (Vector2i position, const RenderWindow* relativeTo)


# SFML/Graphics/Shader.h
################################################################################

cdef extern from 'SFML/Graphics/Shader.h' nogil:
    cdef Shader* Shader_create_from_file 'sfShader_createFromFile' (const char* vertexShaderFilename, const char* fragmentShaderFilename)
    cdef Shader* Shader_create_from_memory 'sfShader_createFromMemory' (const char* vertexShader, const char* fragmentShader)
    cdef Shader* Shader_create_from_stream 'sfShader_createFromStream' (InputStream* vertexShaderStream, InputStream* fragmentShaderStream)
    cdef void Shader_destroy 'sfShader_destroy' (Shader* shader)
    cdef void Shader_set_float_parameter 'sfShader_setFloatParameter' (Shader* shader, const char* name, float x)
    cdef void Shader_set_float2_parameter 'sfShader_setFloat2Parameter' (Shader* shader, const char* name, float x, float y)
    cdef void Shader_set_float3_parameter 'sfShader_setFloat3Parameter' (Shader* shader, const char* name, float x, float y, float z)
    cdef void Shader_set_float4_parameter 'sfShader_setFloat4Parameter' (Shader* shader, const char* name, float x, float y, float z, float w)
    cdef void Shader_set_vector2_parameter 'sfShader_setVector2Parameter' (Shader* shader, const char* name, Vector2f vector)
    cdef void Shader_set_vector3_parameter 'sfShader_setVector3Parameter' (Shader* shader, const char* name, Vector3f vector)
    cdef void Shader_set_color_parameter 'sfShader_setColorParameter' (Shader* shader, const char* name, Color color)
    cdef void Shader_set_transform_parameter 'sfShader_setTransformParameter' (Shader* shader, const char* name, Transform transform)
    cdef void Shader_set_texture_parameter 'sfShader_setTextureParameter' (Shader* shader, const char* name, Texture* texture)
    cdef void Shader_set_current_texture_parameter 'sfShader_setCurrentTextureParameter' (Shader* shader, const char* name)
    cdef void Shader_bind 'sfShader_bind' (const Shader* shader)
    cdef bint Shader_is_available 'sfShader_isAvailable' ()


# SFML/Graphics/Text.h
################################################################################

cdef extern from 'SFML/Graphics/Text.h' nogil:
    ctypedef enum TextStyle 'sfTextStyle':
        # TODO
        TEXT_REGULAR 'sfTextRegular'
        TEXT_BOLD 'sfTextBold'
        TEXT_ITALIC 'sfTextItalic'
        TEXT_UNDERLINED 'sfTextUnderlined'
    
    cdef Text* Text_create 'sfText_create' ()
    cdef Text* Text_copy 'sfText_copy' (Text* text)
    cdef void Text_destroy 'sfText_destroy' (Text* text)
    cdef void Text_set_position 'sfText_setPosition' (Text* text, Vector2f position)
    cdef void Text_set_rotation 'sfText_setRotation' (Text* text, float angle)
    cdef void Text_set_scale 'sfText_setScale' (Text* text, Vector2f scale)
    cdef void Text_set_origin 'sfText_setOrigin' (Text* text, Vector2f origin)
    cdef Vector2f Text_get_position 'sfText_getPosition' (const Text* text)
    cdef float Text_get_rotation 'sfText_getRotation' (const Text* text)
    cdef Vector2f Text_get_scale 'sfText_getScale' (const Text* text)
    cdef Vector2f Text_get_origin 'sfText_getOrigin' (const Text* text)
    cdef void Text_move 'sfText_move' (const Text* text, Vector2f offset)
    cdef void Text_rotate 'sfText_rotate' (const Text* text, float angle)
    cdef void Text_scale 'sfText_scale' (const Text* text, Vector2f scale)
    cdef Transform Text_get_transform 'sfText_getTransform' (const Text* text)
    cdef Transform Text_get_inverse_transform 'sfText_getInverseTransform' (const Text* text)
    cdef void Text_set_string 'sfText_setString' (const Text* text, const char* string)
    cdef void Text_set_unicode_string 'sfText_setUnicodeString' (const Text* text, const Uint32* string)
    cdef void Text_set_font 'sfText_setFont' (const Text* text, const Font* font)
    cdef void Text_set_character_size 'sfText_setCharacterSize' (const Text* text, unsigned int size)
    cdef void Text_set_style 'sfText_setStyle' (Text* text, Uint32 style)
    cdef void Text_set_color 'sfText_setColor' (Text* text, Color color)
    cdef const char* Text_get_string 'sfText_getString' (const Text* text)
    cdef const Uint32* Text_get_unicode_string 'sfText_getUnicodeString' (const Text* text)
    cdef const Font* Text_get_font 'sfText_getFont' (const Text* text)
    cdef unsigned int Text_get_character_size 'sfText_getCharacterSize' (const Text* text)
    cdef Uint32 Text_get_style 'sfText_getStyle' (const Text* text)
    cdef Color Text_get_color 'sfText_getColor' (const Text* text)
    cdef Vector2f Text_find_character_pos 'sfText_findCharacterPos'(const Text* text, size_t index)
    cdef FloatRect Text_get_local_bounds 'sfText_getLocalBounds' (const Text* text)
    cdef FloatRect Text_get_global_bounds 'sfText_getGlobalBounds' (const Text* text)

