# for clion project

#---------------------------------------------------------------------------------------------------
# default
#---------------------------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.17)    # 3.31
project(moran)

set(CMAKE_CXX_STANDARD 14)
#set(CMAKE_CXX_STANDARD 20)				# botan 3.x requires at least C++20

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

#---------------------------------------------------------------------------------------------------
# build
#---------------------------------------------------------------------------------------------------
# find botan library
include(botan/build_botan.cmake)

# build botan-test
add_subdirectory(botan-test)

# moran output setting
set(moran_static_lib_output_name ${CMAKE_PROJECT_NAME})
set(moran_shared_lib_output_name ${CMAKE_PROJECT_NAME})
if(MSVC)
	set(moran_static_lib_output_name "${CMAKE_PROJECT_NAME}_static")
	if(CMAKE_BUILD_TYPE STREQUAL "Debug")
		set(moran_static_lib_output_name "${CMAKE_PROJECT_NAME}d_static")
		set(moran_shared_lib_output_name "${CMAKE_PROJECT_NAME}d")
	endif()
endif()
# build moran library
add_subdirectory(src)

# build moran tests
add_subdirectory(tests)

