#ifndef INTERVIEW_BINARY_TREE_
#define INTERVIEW_BINARY_TREE_

#include <iostream>

struct node
{
    int value;
    node *left;
    node *right;

    node(int x) {
        value = x;
        left = NULL;
        right = NULL;
    }
};

int count_nodes(node *tree);
node* bal_tree_add(node *tree, int value);
node* bal_tree_find(node *tree, int value);

#endif  // INTERVIEW_BINARY_TREE_
