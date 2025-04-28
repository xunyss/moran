# botan library install on linux
# $ python configure.py
# $ make

# environments
CXX            = g++
LINKER         = $(CXX)
AR             = ar
AR_OPTIONS     = crs
EXE_LINK_CMD   = $(LINKER)
BOTAN_HOME     = /home/ipron/tbcrypto/Botan-2.17.3


# compiler flags
ABI_FLAGS		= -fstack-protector -m64 -pthread
LANG_FLAGS		= -std=c++11 -D_REENTRANT
CXX_FLAGS		= -O3 -DBOTAN_IS_BEING_BUILT
WARN_FLAGS		= -Wall -Wextra -Wpedantic -Wstrict-aliasing -Wcast-align -Wmissing-declarations -Wpointer-arith -Wcast-qual -Wzero-as-null-pointer-constant -Wnon-virtual-dtor
LIB_FLAGS		= -fPIC
LDFLAGS			=
LIB_LINKS_TO	= -ldl -lrt
EXE_LINKS_TO	= -L$(BOTAN_HOME) -lbotan-2 $(LIB_LINKS_TO) # .so 파일이 있으면 dynamic, 없고 .a 파일이 있으면 static link 됨 (둘다 있으면 dynamic)
EXE_STATIC_LINK	= $(BOTAN_HOME)/libbotan-2.a # lib 나 실행파일 생성시 static 으로 import 하게 됨
BUILD_FLAGS		= $(ABI_FLAGS) $(LANG_FLAGS) $(CXX_FLAGS) $(WARN_FLAGS)


# targets
build: clean lib sample test

clean:
	rm -f libtbcrypto.a libtbcrypto_depend_botan.so libtbcrypto.so tbcrypto.o
	rm -f sample-c sample-c.o sample-cpp sample-cpp.o
	rm -f botan-test-dynamic botan-test-static botan-test.o
lib: ./libtbcrypto.a ./libtbcrypto.so

sample: ./sample-c ./sample-cpp
	./sample-c
	./sample-cpp

test: ./botan-test
	./botan-test-static


./libtbcrypto.a: ./tbcrypto.o
	$(AR) $(AR_OPTIONS) $@ ./tbcrypto.o

./libtbcrypto.so: ./tbcrypto.o
	$(CXX) -shared $(LIB_FLAGS) -Wl,-soname,libtbcrypto-botan.so $(ABI_FLAGS) $(LDFLAGS) ./tbcrypto.o $(EXE_LINKS_TO) -o libtbcrypto_depend_botan.so
	$(CXX) -shared $(LIB_FLAGS) -Wl,-soname,$@ $(ABI_FLAGS) $(LDFLAGS) ./tbcrypto.o $(EXE_STATIC_LINK) -o $@

./tbcrypto.o: tbcrypto.cpp
	$(CXX) $(LIB_FLAGS) $(BUILD_FLAGS) -I$(BOTAN_HOME)/build/include -I$(BOTAN_HOME)/build/include/external -c tbcrypto.cpp -o $@


./sample-c: ./sample-c.o
	gcc ./sample-c.o -L. -ltbcrypto -lstdc++ -o $@

./sample-c.o: sample-c.c
	gcc -c sample-c.c -o $@

./sample-cpp: ./sample-cpp.o
	$(CXX) ./sample-cpp.o -L. -ltbcrypto -o $@

./sample-cpp.o: sample-cpp.cpp
	$(CXX) -c sample-cpp.cpp -o $@


./botan-test: ./botan-test.o
	$(EXE_LINK_CMD) $(ABI_FLAGS) ./botan-test.o $(LDFLAGS) $(EXE_LINKS_TO) -o $@-dynamic
	$(EXE_LINK_CMD) $(ABI_FLAGS) ./botan-test.o $(LDFLAGS) $(EXE_STATIC_LINK) -o $@-static

./botan-test.o: botan-test.cpp
	$(CXX) $(BUILD_FLAGS) -I$(BOTAN_HOME)/build/include -I$(BOTAN_HOME)/build/include/external -c botan-test.cpp -o $@

