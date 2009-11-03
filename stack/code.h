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

void push(node *&list, int value);
int pop(node *&list);

#endif  // INTERVIEW_CODE_
