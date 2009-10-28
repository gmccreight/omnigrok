typedef struct ListElement {
    struct ListElement *next;
    int data;
}

bool insertElement( ListElement **head, int data ) {
    ListElement elem = ListElement;
    *head->next = elem;
    return true;
}

bool deleteElement( ListElement **head, ListElement *deleteMe ) {

    ListElement *elem = *head;

    if (deleteMe == *head) {
        /* special case for head */
        *head = elem->next;
        delete deleteMe;
        return true;
    }

    while (elem) {
        if ( elem->next == deleteMe ) {
            /* elem is element preceeding deleteMe */
            elem->next = deleteMe->next;
            delete deleteMe;
            return true;
        }
        elem = elem->next;
    }

    /* deleteMe not found */
    return false;

}
