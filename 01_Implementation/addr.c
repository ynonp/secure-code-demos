#include <stdio.h>

int main(int argc, char **argv)
{
  char buf[16];

  printf("Stack address: %p\n", buf);
  printf("Program address: %p\n", main);
  printf("printf address: %p\n", printf);
}

