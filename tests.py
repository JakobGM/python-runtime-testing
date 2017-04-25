import unittest
from sorting_algorithms import insertion_sorted
import generate_random


class TestInsertionSort(unittest.TestCase):

    def test_simple_sorted(self):
        array = [2, 7, 6, 0, -2]
        unsorted = array[:]
        implementation = insertion_sorted(array)
        solution = sorted(unsorted)
        self.assertEqual(implementation, solution)

    def test_complex_sorted(self):
        array = generate_random.numbers(of_type=float)
        implementation = insertion_sorted(array)
        solution = sorted(array)
        self.assertEqual(implementation, solution)


if __name__ == "__main__":
    unittest.main()
