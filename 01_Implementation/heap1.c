#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
  int MAX_SIZE = 10;

  char *buf = (char *)malloc(sizeof(char) * MAX_SIZE);

  gets(buf);
  printf("Got: %s\n", buf);
}
