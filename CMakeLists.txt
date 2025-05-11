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


if(CMAKE_SIZEOF_VOID_P EQUAL 8)					# target arch: x64/x86_64/amd64
	set(x_arch "64")
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)				# target arch: x86/i686
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

# Botan-2.17.3_{mingw|msvc}_x86_{32|64}_{|static}_{|debug}
#set(botan_home		"c:/xdev/works/clion-projects/botan/Botan-2.17.3_${x_cc}_x86_${x_arch}${x_link}${x_build}")
#set(botan_home		"c:/xdev/works/moran/botan/Botan-2.19.5")
#set(BOTAN_INCLUDE	"${CMAKE_SOURCE_DIR}/${botan_home}/build/include")

set(BOTAN_LIBRARY	"${x_botan}")
set(TARGET_LIBRARY	"${x_lib}")


set(botan_include_dir "${botan_home}/build/include")
set(botan_library_dir "${CMAKE_SOURCE_DIR}/${botan_home}")

add_subdirectory(test-botan)
add_subdirectory(lib)

#target_link_directories(botan-test-shared PRIVATE ${botan_home})
#target_link_libraries(botan-test-shared PRIVATE "botan")
#target_link_libraries(botan-test-shared PRIVATE "${CMAKE_SOURCE_DIR}/${botan_home}/botan.lib")	# msvc 에서 shared, static 모두 botan.lib 파일 지정

##---------------------------------------------------------------------------------------------------
## build sample
##---------------------------------------------------------------------------------------------------
#add_executable(sample-cpp sample-cpp.cpp)
#target_link_libraries(sample-cpp PRIVATE ${TARGET_LIBRARY})
#add_executable(sample-c sample-c.c)
#target_link_libraries(sample-c PRIVATE ${TARGET_LIBRARY})
add_executable(sample-c sample-c.c)
target_link_libraries(sample-c PRIVATE "moran")

