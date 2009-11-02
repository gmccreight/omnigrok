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
    tree = bal_tree_add(tree, 8);
    std::vector<int> vec;
    bal_tree_traverse(tree, vec);
    //std::cout << vec.size() << "\n";
    //std::cout << vec.capacity() << "\n";
    EXPECT_EQ(2, vec[0]);
    EXPECT_EQ(4, vec[1]);
    EXPECT_EQ(6, vec[2]);
    EXPECT_EQ(8, vec[3]);
    EXPECT_EQ(10, vec[4]);
    EXPECT_EQ(12, vec[5]);
}
