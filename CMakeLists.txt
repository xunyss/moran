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
##########################
set(hello "world")
#add_subdirectory(botan)
include(botan/build_botan.cmake)


##TEST
message(STATUS "debug===")
message(NOTICE "${CMAKE_SYSTEM_NAME}")
message(NOTICE "${CMAKE_BUILD_TYPE}")
message("WIN32 : ${WIN32}")
message("APPLE : ${APPLE}")
message("UNIX : ${UNIX}")
message("MINGW : ${MINGW}")
message("MSVC : ${MSVC}")
#get_cmake_property(_variableNames VARIABLES)
#foreach (_variableName ${_variableNames})
#    message("${_variableName}=${${_variableName}}")
#endforeach()
##TEST

# case
# 1. mingw / x64 / static / release	: Botan-2.00.0_mingw_x86-64_static_release
# 2. mingw / x64 / static / debug	: Botan-2.00.0_mingw_x86-64_static_debug
#  .								: Botan-2.00.0_mingw_i686_static_release
#  .								: Botan-2.00.0_mingw_i686_static_debug
# 3. msvc / x64 / shared / release	: Botan-2.00.0_msvc_x64_shared_release
# 4. msvc / x64 / shared / debug	: Botan-2.00.0_msvc_x64_shared_debug
# 5. msvc / x64 / static / release	: Botan-2.00.0_msvc_x64_static_release
# 6. msvc / x64 / static / debug	: Botan-2.00.0_msvc_x64_static_debug
#  . msvc / x32 / shared / release	: Botan-2.00.0_msvc_x32_shared_release
#  . msvc / x32 / shared / debug	: Botan-2.00.0_msvc_x32_shared_debug
#  . msvc / x32 / static / release	: Botan-2.00.0_msvc_x32_static_release
#  . msvc / x32 / static / debug	: Botan-2.00.0_msvc_x32_static_debug

#									: Botan-2.00.0_linux_x86-64_release
#									: Botan-2.00.0_linux_x86-64_debug

#									: Botan-2.00.0_mac_arm64_release
#									: Botan-2.00.0_mac_arm64_debug


if(WIN32)
	if(MINGW)
		set(BOTAN_LIB_NAME "botan-2")
	elseif(MSVC)
		set(BOTAN_LIB_NAME "botan")
	endif ()
elseif(APPLE)
	message("APPLE")
elseif(UNIX)
	message("UNIX")
endif()


# system requirement / clion
# Windows - MinGW
# MacOS - cmake
# Linux -

if(CMAKE_SIZEOF_VOID_P EQUAL 8)					# target arch: x64/x86_64/amd64
	set(x_arch "64")
	message("-------------> 64")
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)				# target arch: x86/i686
	set(x_arch "32")
	message("-------------> 32")
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

# Botan-2.17.3_{mingw|msvc}_x86_{32|64}_{|static}_{|debug}
#set(botan_home		"c:/xdev/works/clion-projects/botan/Botan-2.17.3_${x_cc}_x86_${x_arch}${x_link}${x_build}")
#set(botan_home		"c:/xdev/works/moran/botan/Botan-2.19.5")
#set(BOTAN_INCLUDE	"${CMAKE_SOURCE_DIR}/${botan_home}/build/include")
set(BOTAN_INCLUDE_DIR	"${botan_home}/build/include")
set(BOTAN_LIBRARY	"${x_botan}")
set(TARGET_LIBRARY	"${x_lib}")


#---------------------------------------------------------------------------------------------------
# build botan-test
#---------------------------------------------------------------------------------------------------
#add_executable(botan-test-static botan-test.cpp)
#target_include_directories(botan-test-static PRIVATE ${BOTAN_INCLUDE_DIR})
##target_link_directories(botan-test PRIVATE ${botan_home})
##target_link_libraries(botan-test PRIVATE "botan-2")		# default: shared-library
##target_link_libraries(botan-test PRIVATE ${BOTAN_LIBRARY})
#target_link_libraries(botan-test-static PRIVATE "${CMAKE_SOURCE_DIR}/${botan_home}/libbotan-2.a")

add_executable(botan-test-shared botan-test.cpp)
target_include_directories(botan-test-shared PRIVATE ${BOTAN_INCLUDE_DIR})
#target_link_libraries(botan-test-shared PRIVATE "${CMAKE_SOURCE_DIR}/${botan_home}/libbotan-2.dylib")

#target_link_directories(botan-test-shared PRIVATE ${botan_home})
#target_link_libraries(botan-test-shared PRIVATE "botan")
target_link_libraries(botan-test-shared PRIVATE "${CMAKE_SOURCE_DIR}/${botan_home}/botan.lib")	# msvc 에서 shared, static 모두 botan.lib 파일 지정


#---------------------------------------------------------------------------------------------------
# build moran library
#---------------------------------------------------------------------------------------------------
#add_library(${TARGET_LIBRARY} SHARED moran.cpp moran.h)
#target_include_directories(${TARGET_LIBRARY} PRIVATE ${BOTAN_INCLUDE})
#target_link_directories(${TARGET_LIBRARY} PRIVATE ${botan_home})
#target_link_libraries(${TARGET_LIBRARY} PRIVATE ${BOTAN_LIB})


##---------------------------------------------------------------------------------------------------
## build sample
##---------------------------------------------------------------------------------------------------
#add_executable(sample-cpp sample-cpp.cpp)
#target_link_libraries(sample-cpp PRIVATE ${TARGET_LIBRARY})
#add_executable(sample-c sample-c.c)
#target_link_libraries(sample-c PRIVATE ${TARGET_LIBRARY})

