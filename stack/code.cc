#include "code.h"

void push(node *&list, int value) {
    node *newnode = new node(value);

    // Set up link to this node
    if (list == NULL) {
        list = newnode;
    }
    else {
        newnode->nxt = list;
        list = newnode;
    }
}

int pop(node *&list) {

    node *temp;
    if (list == NULL) {
        return NULL;
    }
    if (list->nxt == NULL) {
        temp = list;
        list = NULL;
        return temp->value;
    }

    temp = list;
    list = list->nxt;
    return temp->value;
}
