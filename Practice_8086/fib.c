#include <stdio.h>

extern int fibonacci(int n);

int main(){
    int n;
    scanf("%d",&n);
    for(int i=0;i<n;i++){
        printf("%d ",fibonacci(i));
    }
}