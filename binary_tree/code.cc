#include <iostream>
#include "code.h"
using namespace std;

int count_nodes(node *tree) {
    if (tree == NULL) {
        return 0;
    }
    return 1 + count_nodes(tree->left) + count_nodes(tree->right);
}

/*
node* bal_tree_add(node *tree, int value) {

    if (tree == NULL) {
        // No tree exists, or went off the bottom
        node *new_node = new node;
        new_node->value = value;
        new_node->left = NULL;
        new_node->right = NULL;
        return new_node;
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
*/

/* void bal_tree_find(node *tree, int value) {
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
*/

