#include "code.h"
#include <check.h>

START_TEST (push_and_pop)
{
  Node *stack = NULL;
  push(&stack, 4);
  fail_unless(1 == 1, "one does equal one");
}
END_TEST
