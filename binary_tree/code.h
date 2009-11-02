#ifndef INTERVIEW_BINARY_TREE_
#define INTERVIEW_BINARY_TREE_

#include <iostream>
#include <vector> // Used to check the traverse values of the tree

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
void bal_tree_traverse(node *tree, std::vector<int>& vec);

#endif  // INTERVIEW_BINARY_TREE_
