cysfml
######

CSFML bindings for Python and Cython.

Why not pySFML?
***************

pySFML is a more advanced, complex and comprehensive binding of SFML using Cython's C++ wrapping features. By comparison, cysfml is not ready for production use. Unless you're interested in filling in the gaps, I recommend using pySFML. The development branch fails to compile or link against SFML successfully on ArchLinux, and the stable 1.3 release does not conveniently expose its Cython API. The complexity of the C++ binding is the reason behind creating a simpler alternative using CSFML. Providing an object-oriented API for a C++ library using it's procedural C-bindings may seem backwards, but in practice the process is not difficult.

Why Cython?
===========

The Cython language allows us to define a consistent API and implementation which can be imported from both Python and Cython. This allows developers to conveniently leverage the flexibility of Python along with the speed of C.

Example
-------

cjoystick.pxd (Cython CSFML binding)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

cdef extern from "CSFML/Window/Joystick.h":
    cdef unsigned int joystick_get_button_count 'sfJoystick_getButtonCount' (unsigned int number)

joystick.pxd (cysfml API header)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

cdef class Joystick:
    cdef public unsigned int number
    cpdef unsigned int button_count(Joystick self)

joystick.pyx (cysfml API implementation)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

from cysfml.window.joystick cimport joystick_get_button_count

cdef class Joystick:
    '''
    Cython API class implementation.
    '''
    def __cinit__(Joystick self, unsigned int number):
        '''
        C initialisation of object.
        '''
        self.number = number
    
    cpdef unsigned int get_button_count(Joystick self):
        return joystick_get_button_count(self.number)
    
    property button_count:
        def __get__(Joystick self):
               

joystick_example.py (Python API usage example)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
from cysfml.window.joystick import Joystick

joystick = Joystick(0)
print joystick.get_button_count()
# Properties are also defined.
print joystick.button_count

joystick_example.pyx (Cython API usage example - faster)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

from cysfml.window.joystick cimport Joystick

cdef Joystick joystick = Joystick(0)
print joystick.get_button_count()

cjoystick_example.pyx (Cython CSFML binding usage example - fastest by a small margin)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

from cysfml.window.joystick cimport joystick_get_button_count

joystick_get_button_count(0)


The only differences between the Python and Cython API usage examples are static typing using the cdef keyword and the option to use properties within Python. This means that code can be optimised by only statically typing variables in Cython - complex refactoring is not required. The CSFML binding can be used directly with slightly less overhead, but this is not recommended for complex projects.


Idioms
======

CSFML Binding
-------------

 - The sf prefix is stripped from the beginning of variable, function and type names.
 - CSFML functions are renamed to not follow CamelCase (sfJoystick_getButtonCount is renamed as joystick_get_button_count).
 - Constants, typically defined within enums, are capitalised for differentiation (sfJoystick_axisCount is renamed as JOYSTICK_AXIS_COUNT).



Performance
===========

 - Data types which cannot be exposed to Python, such as C arrays, are converted to Python collection datatypes, such as tuples, lists and dictionaries, for convenience. In many cases Cython-only implementations are provided for more efficient options.
 - Cython extension types wrapping CSFML structs enable the Pythonic object-oriented API. This will incur a small performance and memory overhead.


Requirements
============

 - CSFML (requires SFML)
 