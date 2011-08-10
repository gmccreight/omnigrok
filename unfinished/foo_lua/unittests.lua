require "lunit"

module( "simple", package.seeall, lunit.testcase )

function test_success()
  assert_true( true, "This test never fails.")
end

module( "enhanced", package.seeall, lunit.testcase )

local foobar = nil

function setup()
  foobar = "Hello World"
end

function teardown()
  foobar = nil
end

function test1()
  assert_equal("Hello World", foobar)
  foobar = string.sub(foobar, 1, 5)
  assert_equal("Hello", foobar)
end

function test2()
  assert_equal("Hello World", foobar)
  foobar = string.sub(foobar, -5)
  assert_equal("World", foobar)
end
