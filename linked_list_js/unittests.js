load("../_test_js/ENV.js");
load("../_test_js/EZTEST.js");
load("code_or_practice_copied.js");

start();

node_a = new Node();
is("default", node_a.value, "node_a's default value");

node_a.value = "new value";
is("new value", node_a.value, "node_a has a new value assigned");

node_b = new Node();
is("default", node_b.value, "node_b's default value should be right");

finish();
