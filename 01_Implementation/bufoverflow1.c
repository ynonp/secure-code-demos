#include <stdio.h>
#include <string.h>

int main( int argc, char **argv )
{
  char password[16];

  printf("Hello - What's the password ?");
  gets( password );

  if ( strncmp(password, "letmein", sizeof(password) ) == 0 )
  {
    printf("Welcome, Master !\n");
  }
  else
  {
    printf("INTRUDER ALERT INTRUDER ALERT\n");
  }
}


