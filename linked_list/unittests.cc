#include "code.h"
#include <gtest/gtest.h>

// This test is named "AddNodes", and belongs to the "NodesTest" test case.
TEST(NodesTest, AddTwoNodes) {
  EXPECT_EQ(0, count_list());
  add_node_at_end(4);
  EXPECT_EQ(1, count_list());
  add_node_at_end(3);
  EXPECT_EQ(2, count_list());
}
