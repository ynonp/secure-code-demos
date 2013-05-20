#include <stdio.h>
#include <strings.h>

int check_password()
{
  char password[16];
  gets(password);

  return ! strncmp(password, "letmein", 16);
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

