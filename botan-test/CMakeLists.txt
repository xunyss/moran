
#---------------------------------------------------------------------------------------------------
# build botan-test
#---------------------------------------------------------------------------------------------------
if(UNIX OR (NOT MINGW) OR botan_home_shared)
	if(botan_home_shared)	# MSVC
		set(botan_include_dir "${CMAKE_SOURCE_DIR}/${botan_home_shared}/build/include")
		set(botan_library_dir "${CMAKE_SOURCE_DIR}/${botan_home_shared}")
	endif()

	#-----------------------------------------------------------------------------------------------
	# [1] botan-test (link boran-shared-library)
	#-----------------------------------------------------------------------------------------------
	add_executable(botan-test-with-shared botan-test.cpp)
	target_include_directories(botan-test-with-shared PRIVATE ${botan_include_dir})
	# method_1) target_link_directories 로 경로를 지정(상대 경로 가능) 하고
	#           target_link_libraries 함수로 library-name 만 명시할 경우 [default link type: shared]
	#target_link_directories(botan-test-with-shared PRIVATE ${botan_library_dir})
	#target_link_libraries(botan-test-with-shared PRIVATE ${botan_library_name})
	target_link_directories(botan-test-with-shared PRIVATE ${botan_library_dir})
	target_link_libraries(botan-test-with-shared PRIVATE ${botan_library_name})
	# method_2) static type 으로 link 하려면 [library file 의 full-path(상대 경로 불가능) 명시 (recommended)]
	#           .a, .so, .dylib 등으로 shared library 명을 명시 하여 shared type 으로도 link 할수 있음
	#			참고로, MSVC 에서는 shared, static 모두 botan.lib 로 library filename 이 동일함
	#target_link_libraries(botan-test-with-shared PRIVATE "${botan_library_dir}/${botan_library_filename}")

endif()

if(UNIX OR MINGW OR botan_home_static)
	if(botan_home_static)	# MSVC
		set(botan_include_dir "${CMAKE_SOURCE_DIR}/${botan_home_static}/build/include")
		set(botan_library_dir "${CMAKE_SOURCE_DIR}/${botan_home_static}")
	endif()

	#-----------------------------------------------------------------------------------------------
	# [2] botan-test (link botan-static-library)
	#-----------------------------------------------------------------------------------------------
	add_executable(botan-test-with-static botan-test.cpp)
	target_include_directories(botan-test-with-static PRIVATE ${botan_include_dir})
	target_link_libraries(botan-test-with-static PRIVATE "${botan_library_dir}/${botan_static_lib_filename}")

endif()

