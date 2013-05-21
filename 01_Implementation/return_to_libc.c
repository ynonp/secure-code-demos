#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

int memory_error()
{
  char foo[16];
  gets(foo);
  return 0;
}


int main()
{
  printf("exit_ptr [%llx]\n", exit );

  memory_error();

  printf("--- THE END ---\n");
}

