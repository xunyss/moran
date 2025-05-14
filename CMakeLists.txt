# for clion project

#---------------------------------------------------------------------------------------------------
# default
#---------------------------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.17)    # 3.31
project(moran)

set(CMAKE_CXX_STANDARD 14)              # 20


#---------------------------------------------------------------------------------------------------
# cmake environment
#---------------------------------------------------------------------------------------------------
# default build type
if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE Debug)
endif()

# print envs
set(env_str "environment: OS: ${CMAKE_SYSTEM_NAME}, target_arch: ${CMAKE_SYSTEM_PROCESSOR}, build_type: ${CMAKE_BUILD_TYPE}")
if(WIN32)
	string(APPEND env_str ", WIN32")
endif()
if(APPLE)
	string(APPEND env_str ", APPLE")
endif()
if(UNIX)
	string(APPEND env_str ", UNIX")
endif()
if(MINGW)
	string(APPEND env_str ", MINGW")
endif()
if(CYGWIN)
	string(APPEND env_str ", CYGWIN")
endif()
if(MSYS)
	string(APPEND env_str ", MSYS")
endif()
if(MSVC)
	string(APPEND env_str ", MSVC")
endif()
if(ANDROID)
	string(APPEND env_str ", ANDROID")
endif()
message(STATUS "[moran] ${env_str}")
message(STATUS "[moran] source_dir: ${CMAKE_SOURCE_DIR}, binary_dir: ${CMAKE_BINARY_DIR}")

# find botan library
include(botan/build_botan.cmake)

# build botan-test
add_subdirectory(botan-test)
# build moran library
add_subdirectory(src)
# build moran tests
add_subdirectory(tests)

#target_link_directories(botan-test-shared PRIVATE ${botan_home})
#target_link_libraries(botan-test-shared PRIVATE "botan")
#target_link_libraries(botan-test-shared PRIVATE "${CMAKE_SOURCE_DIR}/${botan_home}/botan.lib")	# msvc 에서 shared, static 모두 botan.lib 파일 지정

##---------------------------------------------------------------------------------------------------
## build sample
##---------------------------------------------------------------------------------------------------
#add_executable(sample-cpp sample-cpp.cpp)
#target_link_libraries(sample-cpp PRIVATE moran_static_lib_botan-static)

#add_executable(sample-c sample-c.c)
#target_link_libraries(sample-c PRIVATE moran_static_lib_botan-static)

