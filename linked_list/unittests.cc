#include "code.h"
#include <gtest/gtest.h>

TEST(NodesTestGrouping, AddSomeNodes) {
  node *list = NULL;
  EXPECT_EQ(0, count_nodes(list));
  list = append_node(list, 4);
  EXPECT_EQ(1, count_nodes(list));
  list = append_node(list, 3);
  EXPECT_EQ(2, count_nodes(list));
}

TEST(NodesTestGrouping, DeleteAllNodes) {
  node *list = NULL;
  EXPECT_EQ(0, count_nodes(list));
  list = append_node(list, 4);
  EXPECT_EQ(1, count_nodes(list));
  list = append_node(list, 3);
  EXPECT_EQ(2, count_nodes(list));
  list = delete_all_nodes(list);
  EXPECT_EQ(0, count_nodes(list));
}
