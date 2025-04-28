
[c 빌드]
gcc -c sample-c.c -o sample-c.o
gcc ./sample-c.o -L. -ltbcrypto -lstdc++ -o sample-c.out


[c++ 빌드]
g++ -c sample-cpp.cpp -o sample-cpp.o
g++ ./sample-cpp.o -L. -ltbcrypto -o sample-cpp.out

