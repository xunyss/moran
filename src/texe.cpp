#include <iostream>
//#include "tlib.h"
__declspec(dllimport) int sum(int a, int b);

using namespace std;

int main() {
    cout << "hello world" << endl;
    cout << "sum: " << sum(1, 2) << endl;
    return 0;
}
