load("../_test/js/ENV.js");
load("../_test/js/EZTEST.js");
load("code_or_practice_copied.js");

start();

// Nodes
node_a = new Node();
isok("default", node_a.value, "node_a's default value");

node_a.value = "cool node a value";
isok("cool node a value", node_a.value, "node_a has a new value assigned");

node_b = new Node();
isok("default", node_b.value, "node_b's default value should be right");

// Linked lists
linked_list = new LinkedList();
isok(0, linked_list.list_values().length, "empty linked list has zero length");
linked_list.append(node_a);
isok(1, linked_list.list_values().length, "the list has been incremented");
linked_list.append(node_b);
isok(2, linked_list.list_values().length, "the list has been incremented again");
isok("cool node a value", linked_list.list_values()[0], "the node a value is right");
isok("default", linked_list.list_values()[1], "the node b value is right");

finish();
