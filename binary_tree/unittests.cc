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

TEST(BinaryTreeTestGrouping, BalTreeAdd) {
    node *tree = bal_tree_add(NULL, 4);
    EXPECT_EQ(1, count_nodes(tree));

    tree = bal_tree_add(tree, 6);
    EXPECT_EQ(2, count_nodes(tree));

    tree = bal_tree_add(tree, 2);
    EXPECT_EQ(3, count_nodes(tree));

    tree = bal_tree_add(tree, 10);
    tree = bal_tree_add(tree, 12);
}

TEST(BinaryTreeTestGrouping, BalTreeFind) {
    node *tree = bal_tree_add(NULL, 4);
    EXPECT_EQ(1, count_nodes(tree));

    tree = bal_tree_add(tree, 6);
    EXPECT_EQ(2, count_nodes(tree));

    tree = bal_tree_add(tree, 2);
    EXPECT_EQ(3, count_nodes(tree));

    EXPECT_EQ(6, bal_tree_find(tree, 6)->value);
    EXPECT_EQ(NULL, bal_tree_find(tree, 10));

}

TEST(BinaryTreeTestGrouping, BalTreeTraverse) {
    node *tree = bal_tree_add(NULL, 4);
    tree = bal_tree_add(tree, 6);
    tree = bal_tree_add(tree, 2);
    tree = bal_tree_add(tree, 10);
    tree = bal_tree_add(tree, 12);
    std::vector<int> v1;
    bal_tree_traverse(tree, v1);
    //std::cout << v1.size() << "\n";
    //std::cout << v1.capacity() << "\n";
    EXPECT_EQ(2, v1[0]);
    EXPECT_EQ(4, v1[1]);
    EXPECT_EQ(6, v1[2]);
    EXPECT_EQ(10, v1[3]);
    EXPECT_EQ(12, v1[4]);
}
