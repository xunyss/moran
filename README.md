# moran
#### botan crypto library wrapper

## build botan
download boran source:
https://botan.randombit.net/#botan2

### Windows with MinGW
```
# for configure.py ..., mingw32-make.exe, execute mingw binary
PATH=%PATH%;C:\Program Files (x86)\JetBrains\CLion 2025.1.1\bin\mingw\bin

cd ./botan/botan-2.19.5
python configure.py --os=mingw
python configure.py --os=mingw --debug-mode
make (or mingw32-make.exe)
```
libbotan-2.a file is created. (shared libs not supported on mingw)

### Windows with MSVC
```
vcvarsall.bat x64
# PATH=%PATH%;C:\PROGRA~2\MIB055~1\2022\BUILDT~1\VC\Tools\MSVC\1443~1.348\bin\Hostx64\x64

cd ./botan/botan-2.19.5
python configure.py --cc=msvc                                      (default: build shared-library)
python configure.py --cc=msvc --debug-mode
python configure.py --cc=msvc --enable-static-library
python configure.py --cc=msvc --enable-static-library --debug-mode
nmake
```
botan.lib, botan.dll

### Linux
```
cd ./botan/botan-2.19.5
python configure.py
python configure.py --debug-mode
make
```
libbotan-2.a, libbotan-2.so files are created.

### MacOS
```
cd ./botan/botan-2.19.5
python3 configure.py
python3 configure.py --debug-mode
make
```
libbotan-2.a, libbotan-2.19.dylib files are created.

## build moran
### Linux
```
# TODO: install cmake

git clone --depth=1 https://github.com/xunyss/moran.git
cmake -S . -B ./build
```
### MinGW
```
PATH=%PATH%;C:\Program Files (x86)\JetBrains\CLion 2025.1.1\bin\cmake\win\x64\bin

cmake -DCMAKE_BUILD_TYPE=Release -G "MinGW Makefiles" -S C:\xdev\works\moran -B C:\xdev\works\moran\cmake-build-release
```

## execute moran
### win
```
PATH=%PATH%;C:\Program Files (x86)\JetBrains\CLion 2025.1.1\bin\cmake\win\x64\bin
```
### mac
```
/Applications/CLion.app/Contents/bin/cmake/mac/aarch64/bin/cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_MAKE_PROGRAM=/Applications/CLion.app/Contents/bin/ninja/mac/aarch64/ninja -G Ninja -S /Users/xuny/xdev/work/xunyss/moran -B /Users/xuny/xdev/work/xunyss/moran/cmake-build-debug
export DYLD_LIBRARY_PATH=.
export DYLD_LIBRARY_PATH=/Users/xuny/xdev/work/xunyss/moran/botan/Botan-2.19.5
install > copy to "/usr/local/lib"
or > ~/bin, ~/lib ... with .zprofile ??
```
### linux
```
LD_LIB~~~
```
