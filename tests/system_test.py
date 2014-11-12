import unittest

from itertools import product
from time import sleep, time

from cysfml import system


class TestVector(unittest.TestCase):
    
    def setUp(self):
        int_values = (-128, 0, 128)
        self._Vector2i_values = product(int_values, int_values)
        unsigned_int_values = (0, 64, 128)
        self._Vector2u_values = product(unsigned_int_values, unsigned_int_values)
        float_values = (-128, -23.58192, 0, 96.2421, 128)
        self._Vector2f_values = product(float_values, float_values)
        self._Vector3f_values = product(float_values, float_values, float_values)
    
    @staticmethod
    def _create_vector_dict(*args):
        vector_dict = {'x': args[0], 'y': args[1]}
        if len(args) > 2:
            vector_dict['z'] = args[2]
        return vector_dict
    
    def _assert_vector_equal(self, vector, *args):
        for key, value in self._create_vector_dict(*args).items():
            self.assertAlmostEqual(vector[key], value, places=5)
    
    def _assert_iterable_equal(self, iterable, *args):
        for value1, value2 in zip(iterable, args):
            self.assertAlmostEqual(value1, value2, places=5)
    
    def _assert_create_vector_equal(self, create_vector_func, *args):
        self._assert_vector_equal(create_vector_func(*args), *args)
    
    def _assert_cast_vector_equal(self, create_vector_func, cast_vector_func, values):
        for args in values:
            castables = (
                create_vector_func(*args),
                self._create_vector_dict(*args),
                tuple(args),
                list(args),
            )
            for castable in castables:
                self._assert_vector_equal(
                    cast_vector_func(castable),
                    *args)
    
    # Vector2i
    
    def test_Vector2i(self):
        for args in self._Vector2i_values:
            self._assert_create_vector_equal(system.Vector2i, *args)
    
    def test_Vector2i_unpack(self):
        for args in self._Vector2i_values:
            self.assertEqual(
                system.Vector2i_unpack(system.Vector2i(*args)),
                args,
            )
    
    def test_Vector2i_cast(self):
        self._assert_cast_vector_equal(
            system.Vector2i,
            system.Vector2i_cast, 
            self._Vector2i_values,
        )
    
    # Vector2u
    
    def test_Vector2u(self):
        for args in self._Vector2u_values:
            self._assert_create_vector_equal(system.Vector2u, *args)
    
    def test_Vector2u_unpack(self):
        for args in self._Vector2u_values:
            self._assert_iterable_equal(
                system.Vector2u_unpack(system.Vector2u(*args)),
                *args)
    
    def test_Vector2u_cast(self):
        self._assert_cast_vector_equal(
            system.Vector2u,
            system.Vector2u_cast, 
            self._Vector2u_values,
        )
    
    # Vector2f
    
    def test_Vector2f(self):
        for args in self._Vector2f_values:
            self._assert_create_vector_equal(system.Vector2f, *args)
    
    def test_Vector2f_unpack(self):
        for args in self._Vector2f_values:
            self._assert_iterable_equal(
                system.Vector2f_unpack(system.Vector2f(*args)),
                *args)
    
    def test_Vector2f_cast(self):
        self._assert_cast_vector_equal(
            system.Vector2f,
            system.Vector2f_cast, 
            self._Vector2f_values,
        )
    
    # Vector3f
    
    def test_Vector3f(self):
        for args in self._Vector3f_values:
            self._assert_create_vector_equal(system.Vector3f, *args)
    
    def test_Vector3f_unpack(self):
        for args in self._Vector3f_values:
            self._assert_iterable_equal(
                system.Vector3f_unpack(system.Vector3f(*args)),
                *args)
        
    def test_Vector3f_cast(self):
        self._assert_cast_vector_equal(
            system.Vector3f,
            system.Vector3f_cast, 
            self._Vector3f_values,
        )


class TestTime(unittest.TestCase):
    
    def test_from_seconds(self):
        for seconds in (-1024.5124, -512.235, 0, 512, 1024.1298):
            time = system.Time.from_seconds(seconds)
            self.assertAlmostEqual(
                time.as_seconds(),
                seconds,
                places=3,
            )
            self.assertAlmostEqual(
                time.seconds,
                seconds,
                places=3,
            )
            # __float__ special method
            self.assertAlmostEqual(
                float(time),
                seconds,
                places=3,
            )
    
    def test_from_milliseconds(self):
        for milliseconds in (-1024, -512, 0, 512, 1024):
            time = system.Time.from_milliseconds(milliseconds)
            self.assertEqual(time.milliseconds, milliseconds)
            self.assertEqual(time.as_milliseconds(), milliseconds)
    
    def test_from_microseconds(self):
        for microseconds in (-1024, -512, 0, 512, 1024):
            time = system.Time.from_microseconds(microseconds)
            self.assertEqual(time.as_microseconds(), microseconds)
            self.assertEqual(time.microseconds, microseconds)
            self.assertEqual(int(time), microseconds)
    
    def test_cmp(self):
        self.assertEqual(
            system.Time.from_microseconds(100),
            system.Time.from_microseconds(100),
        )
        self.assertNotEqual(
            system.Time.from_microseconds(100),
            system.Time.from_microseconds(99),
        )
        self.assertTrue(
            system.Time.from_microseconds(100) >
            system.Time.from_microseconds(-100)
        )
        self.assertFalse(
            system.Time.from_microseconds(-100) >
            system.Time.from_microseconds(-100)
        )
        self.assertFalse(
            system.Time.from_microseconds(-100) >
            system.Time.from_microseconds(100)
        )
        self.assertTrue(
            system.Time.from_microseconds(100) >=
            system.Time.from_microseconds(-100)
        )
        self.assertTrue(
            system.Time.from_microseconds(-100) >=
            system.Time.from_microseconds(-100)
        )
        self.assertFalse(
            system.Time.from_microseconds(-100) >=
            system.Time.from_microseconds(100)
        )
        self.assertTrue(
            system.Time.from_microseconds(-100) <
            system.Time.from_microseconds(100)
        )
        self.assertFalse(
            system.Time.from_microseconds(-100) <
            system.Time.from_microseconds(-100)
        )
        self.assertFalse(
            system.Time.from_microseconds(100) <
            system.Time.from_microseconds(-100)
        )
        self.assertTrue(
            system.Time.from_microseconds(100) >=
            system.Time.from_microseconds(-100)
        )
        self.assertTrue(
            system.Time.from_microseconds(-100) >=
            system.Time.from_microseconds(-100)
        )
        self.assertFalse(
            system.Time.from_microseconds(-100) >=
            system.Time.from_microseconds(100)
        )


class TestClock(unittest.TestCase):
    def test_restart(self):
        clock = system.Clock()
        sleep(0.01)
        clock.restart()

        self.assertTrue(clock.get_elapsed_seconds() < 0.005)
    
    def test_get_elapsed(self):
        clock = system.Clock()
        seconds = 0.01
        sleep(seconds)
        # Allow for minimal inaccuracy.
        seconds -= 0.001
        milliseconds = seconds * 1000
        microseconds = seconds * 1000000
        elapsed_time = clock.get_elapsed_time()
        self.assertTrue(clock.get_elapsed_seconds() > seconds)
        self.assertTrue(clock.elapsed_seconds > seconds)
        self.assertTrue(elapsed_time.seconds > seconds)
        self.assertTrue(clock.get_elapsed_milliseconds() > milliseconds)
        self.assertTrue(clock.elapsed_milliseconds > milliseconds)
        self.assertTrue(elapsed_time.milliseconds > milliseconds)
        self.assertTrue(clock.get_elapsed_microseconds() > microseconds)
        self.assertTrue(clock.elapsed_microseconds > microseconds)
        self.assertTrue(elapsed_time.microseconds > microseconds)
    
    def test_destroy(self):
        clock = system.Clock()
        clock.destroy()


class TestSleep(unittest.TestCase):
    def test_sleep(self):
        seconds = 0.01
        milliseconds = seconds * 1000
        microseconds = seconds * 1000000
        start_time = time()
        system.sleep(system.Time.from_microseconds(microseconds))
        self.assertTrue((time() - start_time) > seconds)
        start_time = time()
        system.sleep_seconds(seconds)
        self.assertTrue((time() - start_time) > seconds)
        start_time = time()
        system.sleep_milliseconds(milliseconds)
        self.assertTrue((time() - start_time) > seconds)
        start_time = time()
        system.sleep_microseconds(microseconds)
        self.assertTrue((time() - start_time) > seconds)


# TODO: TestMutex

# TODO: TestInputStream

# TODO: TestThread

if __name__ == '__main__':
    unittest.main()

