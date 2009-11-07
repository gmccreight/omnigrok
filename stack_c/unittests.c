#include "code.h"
#include "../_test_c_check/src/check.h"
#include <stdio.h>

START_TEST (test_push_and_pop)
{
  Node *stack = NULL;
  push(&stack, 4);
  fail_unless(1 == 1, "one does equal one");
}
END_TEST

START_TEST (test_something_else)
{
  Node *stack = NULL;
  push(&stack, 4);
  fail_unless(1 == 1, "one does equal one");
}
END_TEST

Suite *
stack_suite (void)
{
  Suite *s = suite_create ("Stack");

  /* Core test case */
  TCase *tc_core = tcase_create ("Core");
  //tcase_add_checked_fixture (tc_core, setup, teardown);
  tcase_add_test (tc_core, test_push_and_pop);
  tcase_add_test (tc_core, test_something_else);
  suite_add_tcase (s, tc_core);

  return s;
}

int
main (void)
{
  int number_failed;
  Suite *s = stack_suite ();
  SRunner *sr = srunner_create (s);
  srunner_run_all (sr, CK_NORMAL);
  number_failed = srunner_ntests_failed (sr);
  srunner_free (sr);
  return (number_failed == 0) ? EXIT_SUCCESS : EXIT_FAILURE;
}
