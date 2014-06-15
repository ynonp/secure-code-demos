#include <stdio.h>
#include <string.h>

int main(int argc, char **argv)
{
  char password[16];

  printf("What's the password?");
  gets(password);

  if ( ! strncmp(password, "letmein", sizeof(password)) )
  {
    printf("Welcome!\n");
  }
  else
  {
    printf("INTRUDER ALERT\n");
  }
}

