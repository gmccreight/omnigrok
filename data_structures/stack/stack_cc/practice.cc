#include "code.h"

// This is a practice file.  Delete methods from this file, then rewrite them
// and run the tests by hitting <c-j>.  That way you don't have to mess with
// the reference implementation.

Stack::Stack() {
    head = NULL;
    return;
}

Stack::~Stack() {
    Node *next;
    while (head) {
        next = head->nxt;
        delete head;
        head = next;
    }
    return;
}

void Stack::push(int value) {
    Node *node = new Node;
    node->value = value;
    node->nxt = head;
    head = node;
    return;
}

int Stack::pop() {
    Node *poppednode;
    if (head == NULL) {
        throw "you can't do that";
    }
    poppednode = head;
    int value = poppednode->value;
    head = poppednode->nxt;
    delete poppednode;
    return value;
}
