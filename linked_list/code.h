#ifndef INTERVIEW_LINKED_LIST_
#define INTERVIEW_LINKED_LIST_

#include <iostream>

struct node
{
    int value;
    node *nxt;        // Pointer to next node

    node(int x) {
        value = x;
        nxt = NULL;
    }
};

node* append_node(node *list, int value);
int count_nodes(node *list);
node* delete_start_node(node *list);
node* delete_all_nodes(node *list);

#endif  // INTERVIEW_LINKED_LIST_
