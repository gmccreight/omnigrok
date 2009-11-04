#ifndef INTERVIEW_CODE_
#define INTERVIEW_CODE_

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

#endif  // INTERVIEW_CODE_
