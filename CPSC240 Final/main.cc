#include <stdio.h>
#include <stdint.h> //To students: the second, third, and fourth header files are probably not needed.
#include <ctime>
#include <cstring>
#include <iostream>
#include <iomanip>
#include <math.h>

extern "C" double circuits();

using namespace std;

int main(int argc, char* argv[])
{

  printf("Welcome to Electric Circuits programmed by Kenneth Tran.\n");
  printf("\n");

  double voltage = circuits(); // calls assembly file to do calculations

  //gets value from assembly file and displays it
  printf("\n");
  printf("The main program received %.8lf and will keep it. A zero will be returned to the OS. \n", voltage);
  printf("\n");
  return 0;
}
