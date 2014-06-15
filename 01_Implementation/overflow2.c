#include <stdio.h>
#include <string.h>

int check_password()
{
  char password[64];
  gets(password);

  return ! strncmp(password, "letmein", 64);
}

int main( int argc, char **argv )
{
  printf("Hello. What's the password ?");

  int master = check_password();

  if ( master )
  {
    printf("Welcome, master\n");
  }
  else
  {
    printf("INTRUDER ALERT\n");
  }
}

