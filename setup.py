
from Cython.Build import cythonize

from setuptools import setup, Extension
from setuptools.dist import Distribution

libraries = ['csfml-system', 'csfml-graphics', 'csfml-network', 'csfml-audio', 'csfml-window']

ext_modules = [
    Extension('cysfml.audio', ['cysfml/audio.pyx'], libraries=libraries),
    Extension('cysfml.graphics', ['cysfml/graphics.pyx'], libraries=libraries),
    Extension('cysfml.system', ['cysfml/system.pyx'], libraries=libraries),    
    Extension('cysfml.window', ['cysfml/window.pyx'], libraries=libraries),
    
    Extension('cysfml.utils', ['cysfml/utils.pyx'], libraries=libraries),    
]
ext_modules = cythonize(ext_modules)


setup(
    name="cysfml",
    ext_modules=ext_modules,
)


