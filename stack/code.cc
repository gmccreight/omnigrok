#include "code.h"

// [tag:ref_to_pntr:gem]
void push(node *&stack, int value) {
    node *newnode = new node(value);

    // Set up link to this node
    if (stack == NULL) {
        stack = newnode;
    }
    else {
        newnode->nxt = stack;
        stack = newnode;
    }
}

int pop(node *&stack) {

    node *temp;
    if (stack == NULL) {
        return NULL;
    }
    if (stack->nxt == NULL) {
        temp = stack;
        stack = NULL;
        return temp->value;
    }

    temp = stack;
    stack = stack->nxt;
    return temp->value;
}
