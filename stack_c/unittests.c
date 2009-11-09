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

START_TEST (test_push_null_stack)
{
  //Node *null_node_ptr = NULL;
  //Node **stack = &null_node_ptr;

  Node **stack;
  create_stack(stack);
  push(stack, 6);
  fail_unless( (*stack)->value == 6, "the value was pushed on correctly");
}
END_TEST


START_TEST (test_push_pre_existing_stack)
{
  node_ptr->value = 10;
  fail_unless( node_ptr->value == 10, "ptr");

  Node **stack = &node_ptr;
  fail_unless( push(stack, 4) == true, "the push was successful");
  fail_unless( (*stack)->value == 4, "the value was pushed on correctly");
  fail_unless( (*stack)->nxt->value == 10, "the initial value is still correct");
}
END_TEST

START_TEST (test_pop)
{
  Node *null_node_ptr = NULL;
  Node **stack = &null_node_ptr;
  push(stack, 5);
  push(stack, 8);

  int value = 0;

  fail_unless(pop(stack, &value) == true, "The first pop succeeded");
  fail_unless(value == 8, "The most recent value");

  fail_unless(pop(stack, &value) == true, "The second pop succeeded");
  fail_unless(value == 5, "The initial value");

  fail_unless(pop(stack, &value) == false, "The pop failed because the stack is empty");
  fail_unless(value == 0, "The most recent value is 0");

}
END_TEST

START_TEST (test_full_cycle)
{
  Node **stack;
  create_stack(stack);
  fail_unless( push(stack, 6), true, "6 was successfully pushed onto the stack");
  fail_unless( (*stack)->value == 6, "the internals are correct");
  fail_unless( push(stack, 10), true, "10 was successfully pushed onto the stack");
  fail_unless( (*stack)->value == 10, "the internals are correct");

  int popped_value = 0;
  fail_unless(pop(stack, &popped_value) == true, "The first pop succeeded");
  fail_unless(popped_value == 10, "The most recent value");

  fail_unless(pop(stack, &popped_value) == true, "The second pop succeeded");
  fail_unless(popped_value == 6, "The initial value");
  
  fail_unless(pop(stack, &popped_value) == false, "The pop failed because the stack is empty");
  fail_unless(popped_value == 0, "The most recent value is 0");

  fail_unless(delete_stack(stack) == true, "The stack was successfully deleted");

}
END_TEST

Suite * stack_suite (void) {
  Suite *s = suite_create ("Stack");

  TCase *tc_core = tcase_create ("Core");
  tcase_add_checked_fixture (tc_core, setup, teardown);
  tcase_add_test (tc_core, test_ptr_to_ptr);
  tcase_add_test (tc_core, test_push_null_stack);
  tcase_add_test (tc_core, test_push_pre_existing_stack);
  tcase_add_test (tc_core, test_pop);
  tcase_add_test (tc_core, test_full_cycle);
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
