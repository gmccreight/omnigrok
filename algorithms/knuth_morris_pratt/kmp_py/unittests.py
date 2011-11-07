from code_or_practice_copied import *

import unittest

class TestKMPFunctions(unittest.TestCase):

    def test_a_match_with_no_previous_sub_matches(self):
        self.assertEqual(kmpMatch("floor", "There are holes in the floor"), 23)

    def test_a_match_previous_sub_matches(self):
        self.assertEqual(kmpMatch("flickering", "The flame is flickering"), 13)

if __name__ == '__main__':
    unittest.main()

#ogfileid:36
