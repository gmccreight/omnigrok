#include "code.h"

node* append_node(node *list, int value) {
    node *newnode = new node(value);

    // Set up link to this node
    if (list == NULL) {
        return newnode;
    }
    else {
        node *temp = list;
        while (temp->nxt != NULL) {
            temp = temp->nxt;
        }
        temp->nxt = newnode;
        return list;
    }
}

int count_nodes(node *list) {
    node *temp = list;
    if (temp == NULL) {
        return 0;
    }
    else {
        int counter = 0;
        while (temp != NULL) {
            counter++;
            temp = temp->nxt;
        }
        return counter;
    }
}

node* delete_all_nodes(node *list) {
    node *temp, *to_delete;
    temp = list;
    if (list == NULL) {
        return NULL;
    }
    while(temp->nxt != NULL) {
        to_delete = temp;
        temp = temp->nxt;
        list = temp;
        delete to_delete;
    }
    delete temp;
    return NULL;
}
