#include <iostream>
#include "code.h"
using namespace std;

int count_nodes(node *tree) {
    if (tree == NULL) {
        return 0;
    }
    return 1 + count_nodes(tree->left) + count_nodes(tree->right);
}

node* bal_tree_add(node *tree, int value) {

    if (tree == NULL) {
        // No tree exists, or went off the bottom
        return new node(value);
    }
    else {
        if (value < tree->value) {
            tree->left = bal_tree_add(tree->left, value);
        }
        else {
            tree->right = bal_tree_add(tree->right, value);
        }
    }
    return tree;
}

node* bal_tree_find(node *tree, int value) {
    while (tree != NULL) {
        if (value == tree->value) {
            return tree;
        }
        else if (value < tree->value) {
            tree = tree->left;
        }
        else {
            tree = tree->right;
        }
    }
    return NULL;
}

// Give this function a tree and an empty vector and it
// will fill the vector with the values in the tree.
void bal_tree_traverse(node *tree, std::vector<int>& vec) {

    if (tree == NULL) {
        return;
    }
    else {
        if (tree->left != NULL) {
            bal_tree_traverse(tree->left, vec);
        }
        vec.push_back(tree->value);
        if (tree->right != NULL) {
            bal_tree_traverse(tree->right, vec);
        }
    }
}
