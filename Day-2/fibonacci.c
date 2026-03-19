#include <stdio.h>

// Declare external assembly function to generate Fibonacci series
extern void fibonacci(int n);

int main(){
    int n;
    printf("Enter number of terms: ");
    scanf("%d", &n); // Read number of terms from user

    fibonacci(n); // Call assembly function to print Fibonacci series
    return 0;
}      

// nasm -f elf32 fib.asm -o fib.o
// gcc -m32 main.c fib.o -o fib
// ./fib