#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <string.h>

int memory_error()
{
  char foo[16];
  gets(foo);
  return 0;
}


int main()
{
  char *path = (char *)malloc(10);
  strcpy(path, "/bin/sh");

  printf("exit_ptr [%llx]\n", exit );
  printf("system_ptr [%llx]\n", system );

  system(path);

  printf("--- THE END ---\n");
}

