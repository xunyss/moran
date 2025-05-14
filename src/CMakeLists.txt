
#---------------------------------------------------------------------------------------------------
# build moran library
#---------------------------------------------------------------------------------------------------
if(UNIX OR (NOT MINGW) OR botan_home_shared)
	if(botan_home_shared)	# MSVC
		set(botan_include_dir "${CMAKE_SOURCE_DIR}/${botan_home_shared}/build/include")
		set(botan_library_dir "${CMAKE_SOURCE_DIR}/${botan_home_shared}")
	endif()

	#-----------------------------------------------------------------------------------------------
	# [1] build shared-library with botan-shared-library
	#-----------------------------------------------------------------------------------------------
	add_library(moran_shared_lib_botan-shared SHARED moran.cpp)
	if(MSVC)
		target_compile_definitions(moran_shared_lib_botan-shared PRIVATE MSVC_SHARED_LIB)
	endif()
#	set_target_properties(moran_shared_lib_botan-shared PROPERTIES OUTPUT_NAME "moran")
	target_include_directories(moran_shared_lib_botan-shared PRIVATE ${botan_include_dir})
	target_link_directories(moran_shared_lib_botan-shared PRIVATE ${botan_library_dir})
	target_link_libraries(moran_shared_lib_botan-shared PRIVATE ${botan_library_name})

	#-----------------------------------------------------------------------------------------------
	# [2] build static-library with botan-shared-library
	#-----------------------------------------------------------------------------------------------
	add_library(moran_static_lib_botan-shared STATIC moran.cpp)
#	set_target_properties(moran_static_lib_botan-shared PROPERTIES OUTPUT_NAME "moran")
	target_include_directories(moran_static_lib_botan-shared PRIVATE ${botan_include_dir})
	target_link_directories(moran_static_lib_botan-shared PRIVATE ${botan_library_dir})
	target_link_libraries(moran_static_lib_botan-shared PRIVATE ${botan_library_name})

endif()

if(UNIX OR MINGW OR botan_home_static)
	if(botan_home_static)	# MSVC
		set(botan_include_dir "${CMAKE_SOURCE_DIR}/${botan_home_static}/build/include")
		set(botan_library_dir "${CMAKE_SOURCE_DIR}/${botan_home_static}")
	endif()

	#-----------------------------------------------------------------------------------------------
	# [3] build shared-library with botan-static-library (recommend)
	#-----------------------------------------------------------------------------------------------
	add_library(moran_shared_lib_botan-static SHARED moran.cpp)
	if(MSVC)
		target_compile_definitions(moran_shared_lib_botan-static PRIVATE MSVC_SHARED_LIB)
	endif()
#	set_target_properties(moran_shared_lib_botan-static PROPERTIES OUTPUT_NAME "moran")
	target_include_directories(moran_shared_lib_botan-static PRIVATE ${botan_include_dir})
	target_link_libraries(moran_shared_lib_botan-static PRIVATE "${botan_library_dir}/${botan_static_lib_filename}")

	#-----------------------------------------------------------------------------------------------
	# [4] build static-library with botan-static-library
	#-----------------------------------------------------------------------------------------------
	add_library(moran_static_lib_botan-static STATIC moran.cpp)
#	set_target_properties(moran_static_lib_botan-static PROPERTIES OUTPUT_NAME "moran")
	target_include_directories(moran_static_lib_botan-static PRIVATE ${botan_include_dir})
	target_link_libraries(moran_static_lib_botan-static PRIVATE "${botan_library_dir}/${botan_static_lib_filename}")

endif()

