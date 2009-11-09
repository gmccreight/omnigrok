#include "code.h"
#include "../_test_c_check/src/check.h"
#include <stdio.h>

Node *node_ptr;

void setup (void) {
  node_ptr = (Node *) malloc(sizeof(Node));
}

void teardown (void) {
  //Should think about freeing node_ptr
}

START_TEST (test_ptr_to_ptr)
{
  node_ptr->value = 13;
  fail_unless( node_ptr->value == 13, "ptr");

  Node **node_ptr_to_ptr;
  node_ptr_to_ptr = &node_ptr;
  fail_unless( (*node_ptr_to_ptr)->value == 13, "ptr to ptr");
}
END_TEST

START_TEST (test_push)
{
  //Test just the pushing works correctly
  node_ptr->value = 10;
  fail_unless( node_ptr->value == 10, "ptr");

  Node **stack = &node_ptr;
  push(stack, 4);
  fail_unless( (*stack)->value == 4, "the value was pushed on correctly");
  fail_unless( (*stack)->nxt->value == 10, "the initial value is still correct");
}
END_TEST

START_TEST (test_push_and_pop)
{
  fail_unless(1 == 1, "one does equal one");
}
END_TEST

Suite * stack_suite (void) {
  Suite *s = suite_create ("Stack");

  TCase *tc_core = tcase_create ("Core");
  tcase_add_checked_fixture (tc_core, setup, teardown);
  tcase_add_test (tc_core, test_ptr_to_ptr);
  tcase_add_test (tc_core, test_push);
  tcase_add_test (tc_core, test_push_and_pop);
  suite_add_tcase (s, tc_core);

  return s;
}

int main (void) {
  int number_failed;
  Suite *s = stack_suite ();
  SRunner *sr = srunner_create (s);
  srunner_run_all (sr, CK_NORMAL);
  number_failed = srunner_ntests_failed (sr);
  srunner_free (sr);
  return (number_failed == 0) ? EXIT_SUCCESS : EXIT_FAILURE;
}
