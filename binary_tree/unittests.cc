#include "code.h"
#include <gtest/gtest.h>

TEST(BinaryTreeTestGrouping, CountTree) {
    // Build a tree manually counting the nodes while it's created
    node *tree = new node(4);
    EXPECT_EQ(1, count_nodes(tree));

    tree->left = new node(2);
    EXPECT_EQ(2, count_nodes(tree));

    tree->right = new node(6);
    EXPECT_EQ(3, count_nodes(tree));

    tree->right->left = new node(5);
    tree->right->right = new node(7);
    EXPECT_EQ(5, count_nodes(tree));
}
