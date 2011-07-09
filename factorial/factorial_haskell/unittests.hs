import Code

import Test.HUnit

test1 = TestCase (assertEqual "factorial for 4" (24) (fac 4))

main = runTestTT test1
