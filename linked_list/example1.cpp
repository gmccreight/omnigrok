#include <iostream>
using namespace std;

// Adapted from: http://richardbowles.tripod.com/cpp/linklist/linklist.htm

struct node
{  char name[20];     // Name of up to 20 letters
    int age;          // D.O.B. would be better
    float height;     // In meters
    node *nxt;        // Pointer to next node
};

node *start_ptr = NULL;
node *current;		 // Used to move along the list
int option = 0;

void add_node_at_end()
{  node *temp, *temp2;   // Temporary pointers

    // Reserve space for new node and fill it with data
    temp = new node;
    cout << "Please enter the name of the person: ";
    cin >> temp->name;
    cout << "Please enter the age of the person : ";
    cin >> temp->age;
    cout << "Please enter the height of the person : ";
    cin >> temp->height;
    temp->nxt = NULL;

    // Set up link to this node
    if (start_ptr == NULL)
    { start_ptr = temp;
        current = start_ptr;
    }
    else
    { temp2 = start_ptr;
        // We know this is not NULL - list not empty!
        while (temp2->nxt != NULL)
        {  temp2 = temp2->nxt;
            // Move to next link in chain
        }
        temp2->nxt = temp;
    }
}

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

int main(void)
{  start_ptr = NULL;
    do
    {
        display_list();
        cout << endl;
        cout << "Please select an option : " << endl;
        cout << "0. Exit the program." << endl;
        cout << "1. Add a node to the end of the list." << endl;
        cout << "2. Delete the start node from the list." << endl;
        cout << "3. Delete the end node from the list." << endl;
        cout << "4. Move the current pointer on one node." << endl;
        cout << "5. Move the current pointer back one node." << endl;
        cout << endl << " >> ";
        cin >> option;

        switch (option)
        {
            case 1 : add_node_at_end(); break;
            case 2 : delete_start_node(); break;
            case 3 : delete_end_node(); break;
            case 4 : move_current_on(); break;
            case 5 : move_current_back();
        }
    }
    while (option != 0);
    return 0;
}
