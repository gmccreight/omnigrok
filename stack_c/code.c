#include "code.h"


void push(Node **stack_ptr_ptr, int value) {

    Node *newnode;
    newnode = (Node *) malloc(sizeof(Node));
    if (newnode == NULL) {
        // The memory allocation failed
        return;
    }

    newnode->value = value;

    //Set up link to this node
    if (stack_ptr_ptr == NULL) {
        *stack_ptr_ptr = newnode;
    }
    else {
        newnode->nxt = *stack_ptr_ptr;
        *stack_ptr_ptr = newnode;
    }
}


int pop(Node **stack) {

//    return (*stack)->value;

    //Node *node;
    //if (!(node = *stack)) return 0;

    //int value = node->value;
    //*stack = node->nxt;
    //delete node;
    //return value;
}
