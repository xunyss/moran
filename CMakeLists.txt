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

##TEST
message(STATUS "debug===")
message(NOTICE "${CMAKE_SYSTEM_NAME}")
message("${WIN32}")
message("${UNIX}")
message("${MINGW}")
message("${MSVC}")
#get_cmake_property(_variableNames VARIABLES)
#foreach (_variableName ${_variableNames})
#    message("${_variableName}=${${_variableName}}")
#endforeach()
##TEST

# botan version
set(BOTAN_VERSION 2.19.5)
# system requirement / clion
# Windows - MinGW
# MacOS - cmake
# Linux -

if(CMAKE_SIZEOF_VOID_P EQUAL 8)					# 64bit
    set(x_arch "64")
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)				# 32bit
    set(x_arch "32")
endif()

if(MINGW)										# mingw
    set(x_botan "botan-2")
    set(x_cc    "mingw")
    set(x_link  "")
else()											# msvc
    set(x_botan "botan")
    set(x_cc    "msvc")
    set(x_link  "_static")
endif()

if(CMAKE_BUILD_TYPE STREQUAL "Debug")			# debug
    set(x_lib "${CMAKE_PROJECT_NAME}${x_arch}d")
    set(x_build "_debug")
else()											# release
    set(x_lib "${CMAKE_PROJECT_NAME}${x_arch}")
    set(x_build "")
endif()

#set(BOTAN_HOME		"c:/xdev/works/clion-projects/botan/Botan-2.17.3_${x_cc}_x86_${x_arch}${x_link}${x_build}")
#set(BOTAN_HOME		"c:/xdev/works/moran/botan/Botan-2.19.5")
set(BOTAN_HOME		"botan/Botan-${BOTAN_VERSION}")
set(BOTAN_INCLUDE	"${BOTAN_HOME}/build/include")
set(BOTAN_LIB		"${x_botan}")
set(TARGET_LIBRARY	"${x_lib}")


#---------------------------------------------------------------------------------------------------
# build botan-test
#---------------------------------------------------------------------------------------------------
add_executable(botan-test botan-test.cpp)
target_include_directories(botan-test PRIVATE ${BOTAN_INCLUDE})
target_link_directories(botan-test PRIVATE ${BOTAN_HOME})
target_link_libraries(botan-test PRIVATE ${BOTAN_LIB})


#---------------------------------------------------------------------------------------------------
# build moran library
#---------------------------------------------------------------------------------------------------
add_library(${TARGET_LIBRARY} SHARED moran.cpp moran.h)
target_include_directories(${TARGET_LIBRARY} PRIVATE ${BOTAN_INCLUDE})
target_link_directories(${TARGET_LIBRARY} PRIVATE ${BOTAN_HOME})
target_link_libraries(${TARGET_LIBRARY} PRIVATE ${BOTAN_LIB})


##---------------------------------------------------------------------------------------------------
## build sample
##---------------------------------------------------------------------------------------------------
add_executable(sample-cpp sample-cpp.cpp)
target_link_libraries(sample-cpp PRIVATE ${TARGET_LIBRARY})
add_executable(sample-c sample-c.c)
target_link_libraries(sample-c PRIVATE ${TARGET_LIBRARY})

