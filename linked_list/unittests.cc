#include "code.h"
#include <gtest/gtest.h>

TEST(NodesTest, AddTwoNodes) {
  delete_all_nodes();
  EXPECT_EQ(0, count_nodes());
  append_node(4);
  EXPECT_EQ(1, count_nodes());
  append_node(3);
  EXPECT_EQ(2, count_nodes());
}

TEST(NodesTest, DeleteStartNode) {
  delete_all_nodes();
  EXPECT_EQ(0, count_nodes());
  append_node(4);
  EXPECT_EQ(1, count_nodes());
  append_node(3);
  EXPECT_EQ(2, count_nodes());
  delete_start_node();
  EXPECT_EQ(1, count_nodes());
}

TEST(NodesTest, DeleteAllNodes) {
  delete_all_nodes();
  EXPECT_EQ(0, count_nodes());
  append_node(4);
  EXPECT_EQ(1, count_nodes());
  append_node(3);
  EXPECT_EQ(2, count_nodes());
  delete_all_nodes();
  EXPECT_EQ(0, count_nodes());
}
