
#-----------------------------------------------------------------------------------------------------------------------
# botan version
file(READ "${CMAKE_SOURCE_DIR}/botan/version.txt" version_str)
string(STRIP "${version_str}" botan_version)

#-----------------------------------------------------------------------------------------------------------------------
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
		foreach(build_type "${CMAKE_BUILD_TYPE}" "Release" "Debug")
			set(find_dir "botan/Botan-${botan_version}_${win_toolchain}_${target_arch}_${build_type}")
			if(EXISTS "${CMAKE_SOURCE_DIR}/${find_dir}" AND EXISTS "${CMAKE_SOURCE_DIR}/${find_dir}/build")
				set(botan_home "${find_dir}")
				break()
			endif()
		endforeach()
		if(NOT botan_home)
			message(FATAL_ERROR "[moran] Cannot find botan library: botan/Botan-${botan_version}_${win_toolchain}_${target_arch}_${CMAKE_BUILD_TYPE}")
		endif()
		message(STATUS "[moran] botan_home: ${botan_home}")

	# msvc: Debug <-> Release 간 호출 불가능, Botan - shared-library, static-library 각각 빌드 해야 함
	elseif(MSVC)
		set(win_toolchain "msvc")
		set(botan_home_shared "botan/Botan-${botan_version}_${win_toolchain}_${target_arch}_shared_${CMAKE_BUILD_TYPE}")
		set(botan_home_static "botan/Botan-${botan_version}_${win_toolchain}_${target_arch}_static_${CMAKE_BUILD_TYPE}")
		if(NOT EXISTS "${CMAKE_SOURCE_DIR}/${botan_home_shared}/build")
			set(botan_home_shared "")
		endif()
		if(NOT EXISTS "${CMAKE_SOURCE_DIR}/${botan_home_static}/build")
			set(botan_home_static "")
		endif()
		if(NOT botan_home_shared AND NOT botan_home_static)
			message(FATAL_ERROR "[moran] Cannot find botan library: botan/Botan-${botan_version}_${win_toolchain}_${target_arch}_{shared|static}}_${CMAKE_BUILD_TYPE}")
		endif()
		message(STATUS "[moran] botan_home_shared: ${botan_home_shared}")
		message(STATUS "[moran] botan_home_static: ${botan_home_static}")

	else()
		message(FATAL_ERROR "[moran] Not support toolchain: ${CMAKE_CXX_COMPILER}")

	endif()

#-----------------------------------------------------------------------------------------------------------------------
# Unix(MacOS, Linux): Debug <-> Release 간 호출 가능
elseif(UNIX)
	foreach(build_type "${CMAKE_BUILD_TYPE}" "Release" "Debug")
		set(find_dir "botan/Botan-${botan_version}_${CMAKE_SYSTEM_NAME}_${CMAKE_SYSTEM_PROCESSOR}_${build_type}")
		if(EXISTS "${CMAKE_SOURCE_DIR}/${find_dir}" AND EXISTS "${CMAKE_SOURCE_DIR}/${find_dir}/build")
			set(botan_home "${find_dir}")
			break()
		endif()
	endforeach()
	if(NOT botan_home)
		message(FATAL_ERROR "[moran] Cannot find botan library: botan/Botan-${botan_version}_${CMAKE_SYSTEM_NAME}_${CMAKE_SYSTEM_PROCESSOR}_${CMAKE_BUILD_TYPE}")
	endif()
	message(STATUS "[moran] botan_home: ${botan_home}")

#-----------------------------------------------------------------------------------------------------------------------
else()
	message(FATAL_ERROR "Not support OS: ${CMAKE_SYSTEM_NAME}")

endif()

