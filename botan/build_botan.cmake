
file(READ "${CMAKE_SOURCE_DIR}/botan/version.txt" version_str)
string(STRIP "${version_str}" botan_version)

# Windows
if(WIN32)
	if(CMAKE_SIZEOF_VOID_P EQUAL 8)			# target arch: x64/x86_64/amd64
		set(target_arch "x64")
	elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)		# target arch: x86/i686
		set(target_arch "x86")
	endif()

	# mingw: Debug <-> Release 간 호출 가능, shared-library 빌드 불가능
	if(MINGW)
		set(win_toolchain "mingw")
		set(botan_home "botan/Botan-${botan_version}_${win_toolchain}_${target_arch}_${CMAKE_BUILD_TYPE}")
		if(NOT EXISTS "${CMAKE_SOURCE_DIR}/${botan_home}")
			if(CMAKE_BUILD_TYPE STREQUAL "Debug")
				set(botan_home "botan/Botan-${botan_version}_${win_toolchain}_${target_arch}_Release")
			elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
				set(botan_home "botan/Botan-${botan_version}_${win_toolchain}_${target_arch}_Debug")
			endif()
		endif()
		if(EXISTS "${CMAKE_SOURCE_DIR}/${botan_home}" AND EXISTS "${CMAKE_SOURCE_DIR}/${botan_home}/build")
			set(enable_static_lib ON)
			set(enable_shared_lib OFF)
		endif()

	# msvc: Debug <-> Release 간 호출 불가능, Botan - shared-library, static-library 각각 빌드 해야 함
	elseif(MSVC)
		set(win_toolchain "msvc")
		set(botan_home "botan/Botan-${botan_version}_${win_toolchain}_${target_arch}_shared_${CMAKE_BUILD_TYPE}")
		set(botan_hom2 "botan/Botan-${botan_version}_${win_toolchain}_${target_arch}_static_${CMAKE_BUILD_TYPE}")
		if(EXISTS "${CMAKE_SOURCE_DIR}/${botan_home}" AND EXISTS "${CMAKE_SOURCE_DIR}/${botan_home}/build")
			set(enable_shared_lib ON)
		endif()
		if(EXISTS "${CMAKE_SOURCE_DIR}/${botan_hom2}" AND EXISTS "${CMAKE_SOURCE_DIR}/${botan_hom2}/build")
			set(enable_static_lib ON)
		endif()

	else()
		message(FATAL_ERROR "Not support toolchain: ${CMAKE_CXX_COMPILER}")

	endif()

	# print error message
	if(NOT enable_shared_lib AND NOT enable_static_lib)
		message(FATAL_ERROR "Cannot find botan library: ${botan_home}")
	endif()
	# print info
	message(STATUS "[moran] OS: ${CMAKE_SYSTEM_NAME}, toolchain: ${win_toolchain}, target_arch: ${target_arch}, build_type: ${CMAKE_BUILD_TYPE}")
	if(MSVC)
		if(enable_shared_lib)
			message(STATUS "[moran] botan_home: ${botan_home}")
		endif()
		if(enable_static_lib)
			message(STATUS "[moran] botan_home: ${botan_hom2}")
		endif()
	else()
		message(STATUS "[moran] botan_home: ${botan_home}")
	endif()

# MacOS, Linux
elseif(UNIX)
	set(enable_static_lib, ON)
	set(enable_shared_lib, ON)
	set(botan_home "botan/Botan-${botan_version}_${CMAKE_SYSTEM_NAME}_${CMAKE_SYSTEM_PROCESSOR}_${CMAKE_BUILD_TYPE}")

	# print error message
	if(NOT EXISTS "${CMAKE_SOURCE_DIR}/${botan_home}")
		message(FATAL_ERROR "Cannot find botan library: ${botan_home}")
	endif()
	# print info
	message(STATUS "[moran] OS: ${CMAKE_SYSTEM_NAME}, target_arch: ${CMAKE_SYSTEM_PROCESSOR}, build_type: ${CMAKE_BUILD_TYPE}")
	message(STATUS "[moran] botan_home: ${botan_home}")

else()
	message(FATAL_ERROR "Not support OS: ${CMAKE_SYSTEM_NAME}")

endif()

