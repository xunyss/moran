# moran
botan crypto library wrapper

### botan build
#### download boran source
https://botan.randombit.net/#botan2
#### Windows with MinGW
```
PATH=%PATH%;C:\Program Files (x86)\JetBrains\CLion 2025.1\bin\mingw\bin
cd ./botan/botan-2.19.5
python configure.py --os=mingw
python configure.py --os=mingw --debug-mode
make (or mingw32-make.exe)
```
libbotan-2.a file is created.
#### Linux
```
cd ./botan/botan-2.19.5
python configure.py
make
```
libbotan-2.a, libbotan-2.so files are created.
#### MacOS
```
cd ./botan/botan-2.19.5
python configure.py
make
```
libbotan-2.a, libbotan-2.19.dylib files are created.

# tmp
#### win
```
PATH=%PATH%;C:\Program Files (x86)\JetBrains\CLion 2025.1\bin\cmake\win\x64\bin
```
#### mac
```
/Applications/CLion.app/Contents/bin/cmake/mac/aarch64/bin/cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_MAKE_PROGRAM=/Applications/CLion.app/Contents/bin/ninja/mac/aarch64/ninja -G Ninja -S /Users/xuny/xdev/work/xunyss/moran -B /Users/xuny/xdev/work/xunyss/moran/cmake-build-debug
export DYLD_LIBRARY_PATH=.
```
#### linux
```
LD_LIB~~~
```
