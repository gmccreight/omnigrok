#ifndef INTERVIEW_CODE_
#define INTERVIEW_CODE_

#include <stdlib.h>

typedef struct Node
{
    struct Node *nxt;
    int value;
} Node;

void push(Node **stack, int value);
int pop(Node **stack);

#endif  // INTERVIEW_CODE_
