#ifndef CS_CODE_
#define CS_CODE_

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

void push(node *&stack, int value);
int pop(node *&stack);

#endif  // CS_CODE_
