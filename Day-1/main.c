#include <stdio.h>

extern void findValues(int arr[], int n, int *max, int *min, int *secMax, int *secMin);

int main() {

    printf("Please enter the Size of the Array: ");
    int n;
    scanf("%d", &n);
    int arr[n];
    printf("Please enter the elements of the Array: ");
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    int max, min, secMax, secMin;

    findValues(arr, n, &max, &min, &secMax, &secMin);

    printf("Maximum: %d\n", max);
    printf("Minimum: %d\n", min);
    printf("Second Maximum: %d\n", secMax);
    printf("Second Minimum: %d\n", secMin);

    return 0;
}

/*
nasm -f elf32 findValues.asm
gcc -m32 main.c findValues.o -o program
./program
*/