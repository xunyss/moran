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
libbotan-2.a file is created. (shared libs not supported on mingw)

#### Windows with MSVC
```
vcvarsall.bat x64
# PATH=%PATH%;C:\PROGRA~2\MIB055~1\2022\BUILDT~1\VC\Tools\MSVC\1443~1.348\bin\Hostx64\x64

cd ./botan/botan-2.19.5
python configure.py --cc=msvc
python configure.py --cc=msvc --debug-mode
python configure.py --cc=msvc --enable-static-library
python configure.py --cc=msvc --enable-static-library --debug-mode
nmake
```
botan.lib, botan.dll

#### Linux
```
cd ./botan/botan-2.19.5
python configure.py
python configure.py --debug-mode
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
export DYLD_LIBRARY_PATH=/Users/xuny/xdev/work/xunyss/moran/botan/Botan-2.19.5
install > copy to "/usr/local/lib"
```
#### linux
```
LD_LIB~~~
```
