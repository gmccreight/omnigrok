#include "code.h"


void push(Node **stack, int value) {
    struct Node *newnode;
    if (!newnode) return;

    newnode->value = value;

    // Set up link to this node
    if (stack == NULL) {
        stack = &newnode;
    }
    else {
        newnode->nxt = *stack;
        stack = &newnode;
    }
}
/*
int pop(Node **stack) {

    Node *temp;
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
*/
