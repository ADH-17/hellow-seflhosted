import unittest
from hellow import get_integers

class TestIntegers(unittest.TestCase):
    def setUp(self):
        self.x, self.y, self.z, self.w = get_integers()

    def test_x_equals_5(self):
        self.assertEqual(self.x, 5)

    def test_y_equals_6(self):
        self.assertEqual(self.y, 6)

    def test_z_equals_2(self):
        self.assertEqual(self.z, 2)

    def test_w_equals_3(self):
        self.assertEqual(self.w, 3)

    def test_x_plus_y(self):
        self.assertEqual(self.x + self.y, 11)

    def test_y_times_z(self):
        self.assertEqual(self.y * self.z, 12)

    def test_w_squared(self):
        self.assertEqual(self.w ** 2, 9)

    def test_sum_all(self):
        self.assertEqual(self.x + self.y + self.z + self.w, 16)

    def test_diff_y_z(self):
        self.assertEqual(self.y - self.z, 4)

    def test_divide_y_by_z(self):
        self.assertEqual(self.y / self.z, 3.0)

if __name__ == "__main__":
    unittest.main()
