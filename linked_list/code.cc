#include <iostream>
using namespace std;

// Adapted from: http://richardbowles.tripod.com/cpp/linklist/linklist.htm

struct node
{  
    int value;
    node *nxt;        // Pointer to next node
};

node *start_ptr = NULL;
node *current;		 // Used to move along the list
int option = 0;

void add_node_at_end(int value) {

    node *temp, *temp2;

    temp = new node;
    temp->value = value;
    temp->nxt = NULL;

    // Set up link to this node
    if (start_ptr == NULL) {
        start_ptr = temp;
        current = start_ptr;
    }
    else {
        temp2 = start_ptr;
        // We know this is not NULL - list not empty!
        while (temp2->nxt != NULL) {
            // Move to next link in chain
            temp2 = temp2->nxt;
        }
        temp2->nxt = temp;
    }
}

int count_list() {
    node *temp;
    temp = start_ptr;
    if (temp == NULL) {
        return 0;
    }
    else {
        int counter = 0;
        while (temp != NULL) {
            counter++;
            temp = temp->nxt;
        }
        return counter;
    }
}

/*
void display_list()
{  node *temp;
    temp = start_ptr;
    cout << endl;
    if (temp == NULL)
        cout << "The list is empty!" << endl;
    else
    { while (temp != NULL)
        {  // Display details for what temp points to
            cout << "Name : " << temp->name << " ";
            cout << "Age : " << temp->age << " ";
            cout << "Height : " << temp->height;
            if (temp == current)
                cout << " <-- Current node";
            cout << endl;
            temp = temp->nxt;

        }
        cout << "End of list!" << endl;
    }
}

void delete_start_node()
{ node *temp;
    temp = start_ptr;
    start_ptr = start_ptr->nxt;
    delete temp;
}

void delete_end_node()
{ node *temp1, *temp2;
    if (start_ptr == NULL)
        cout << "The list is empty!" << endl;
    else
    { temp1 = start_ptr;
        if (temp1->nxt == NULL)
        { delete temp1;
            start_ptr = NULL;
        }
        else
        { while (temp1->nxt != NULL)
            { temp2 = temp1;
                temp1 = temp1->nxt;
            }
            delete temp1;
            temp2->nxt = NULL;
        }
    }
}

    void move_current_on ()
{ if (current->nxt == NULL)
    cout << "You are at the end of the list." << endl;
    else
        current = current->nxt;
}

    void move_current_back ()
{ if (current == start_ptr)
    cout << "You are at the start of the list" << endl;
    else
    { node *previous;     // Declare the pointer
        previous = start_ptr;

        while (previous->nxt != current)
        { previous = previous->nxt;
        }
        current = previous;
    }
}
*/
