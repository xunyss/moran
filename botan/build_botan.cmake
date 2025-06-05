
#-----------------------------------------------------------------------------------------------------------------------
# botan version
file(READ "${CMAKE_SOURCE_DIR}/botan/version.txt" version_str)
string(STRIP "${version_str}" botan_version)

#-----------------------------------------------------------------------------------------------------------------------
# functions
# run_get_botan_script
function(run_get_botan_script botan_dir_name)
	if(WIN32)
		execute_process(
				COMMAND cmd /c "${CMAKE_SOURCE_DIR}/botan/get_botan.bat" "${botan_dir_name}"
				WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/botan
				RESULT_VARIABLE get_botan_script_result
		)
	else()
		execute_process(
				COMMAND bash ${CMAKE_SOURCE_DIR}/botan/get_botan "${botan_dir_name}"
				WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/botan
				RESULT_VARIABLE get_botan_script_result
		)
	endif()
	if(NOT get_botan_script_result EQUAL 0)
		message(FATAL_ERROR "Failed to execute get_botan script: ${get_botan_script_result}")
	endif()
endfunction()

# check_botan_home_dir
function(check_botan_home_dir botan_home_dir result_var)
	if(EXISTS "${CMAKE_SOURCE_DIR}/${botan_home_dir}" AND EXISTS "${CMAKE_SOURCE_DIR}/${botan_home_dir}/build")
		set(${result_var} "${botan_home_dir}" PARENT_SCOPE)
		return()
	endif()
	set(${result_var} "" PARENT_SCOPE)
endfunction()

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
			check_botan_home_dir(${find_dir} botan_home)
			if(botan_home)
				break()
			endif()
		endforeach()
		if(NOT botan_home)
			set(botan_dir_name "Botan-${botan_version}_${win_toolchain}_${target_arch}_${CMAKE_BUILD_TYPE}")
			run_get_botan_script("${botan_dir_name}")
			message(FATAL_ERROR "[moran] Cannot find botan build: botan/${botan_dir_name}")
		endif()
		message(STATUS "[moran] botan_home: ${botan_home}")

	# msvc: Debug <-> Release 간 호출 불가능, Botan - shared-library, static-library 각각 빌드 해야 함
	elseif(MSVC)
		set(win_toolchain "msvc")
		set(link_types "shared;static")
		foreach(link_type ${link_types})
			set(find_dir "botan/Botan-${botan_version}_${win_toolchain}_${target_arch}_${link_type}_${CMAKE_BUILD_TYPE}")
			check_botan_home_dir(${find_dir} botan_home_${link_type})
		endforeach()
		if(NOT botan_home_shared AND NOT botan_home_static)
			foreach(link_type ${link_types})
				run_get_botan_script("Botan-${botan_version}_${win_toolchain}_${target_arch}_${link_type}_${CMAKE_BUILD_TYPE}")
			endforeach()
			message(FATAL_ERROR "[moran] Cannot find botan build: botan/Botan-${botan_version}_${win_toolchain}_${target_arch}_{shared|static}_${CMAKE_BUILD_TYPE}")
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
		check_botan_home_dir(${find_dir} botan_home)
		if(botan_home)
			break()
		endif()
	endforeach()
	if(NOT botan_home)
		set(botan_dir_name "Botan-${botan_version}_${CMAKE_SYSTEM_NAME}_${CMAKE_SYSTEM_PROCESSOR}_${CMAKE_BUILD_TYPE}")
		run_get_botan_script("${botan_dir_name}")
		message(FATAL_ERROR "[moran] Cannot find botan build: botan/${botan_dir_name}")
	endif()
	message(STATUS "[moran] botan_home: ${botan_home}")

#-----------------------------------------------------------------------------------------------------------------------
else()
	message(FATAL_ERROR "Not support OS: ${CMAKE_SYSTEM_NAME}")

endif()


#-----------------------------------------------------------------------------------------------------------------------
set(botan_include_dir "${CMAKE_SOURCE_DIR}/${botan_home}/build/include")	# 상대경로 사용가능
set(botan_shared_library_dir "${CMAKE_SOURCE_DIR}/${botan_home}")			# 상대경로 사용가능 (static 링킹시에는 full-path 절대경로 필요)
# MSVC
if(MSVC)
	if(botan_home_shared)
		set(botan_shared_library_dir "${CMAKE_SOURCE_DIR}/${botan_home_shared}")
	endif()
	set(botan_library_name "botan")
	if(botan_home_static)
		set(botan_static_lib_filepath "${CMAKE_SOURCE_DIR}/${botan_home_static}/${botan_library_name}.lib")
	endif()
# MINGW, UNIX(APPLE, LINUX)
else()
	set(botan_library_name "botan-2")
	set(botan_static_lib_filepath "${botan_shared_library_dir}/lib${botan_library_name}.a")
endif()

