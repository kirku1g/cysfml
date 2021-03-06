
from Cython.Build import cythonize

from setuptools import setup, Extension
from setuptools.dist import Distribution

libraries = ['csfml-system', 'csfml-graphics', 'csfml-network', 'csfml-audio', 'csfml-window']

ext_modules = [
    Extension('examples.example', ['examples/example.pyx'], libraries=libraries),    
]
ext_modules = cythonize(ext_modules)


setup(
    name="examples",
    ext_modules=ext_modules,
)


