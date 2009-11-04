#include "code.h"
#include <gtest/gtest.h>

TEST(StackTestGrouping, PushAndPop) {
  node *stack = NULL;
  EXPECT_EQ(NULL, pop(stack));
  push(stack, 4);
  push(stack, 6);
  EXPECT_EQ(6, pop(stack));
  EXPECT_EQ(4, pop(stack));
  EXPECT_EQ(NULL, pop(stack));
}
