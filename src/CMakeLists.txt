
#===================================================================================================
# build moran library
#===================================================================================================
if(UNIX OR MINGW OR (MSVC AND botan_home_static))
	if(MSVC AND botan_home_static)
		set(botan_include_dir "${CMAKE_SOURCE_DIR}/${botan_home_static}/build/include")
	endif()

	#-----------------------------------------------------------------------------------------------
	# [1] build static-library
	#-----------------------------------------------------------------------------------------------
	add_library(moran_static_lib STATIC moran.cpp)
	set_target_properties(moran_static_lib PROPERTIES OUTPUT_NAME ${moran_static_lib_output_name})
	target_include_directories(moran_static_lib PRIVATE ${botan_include_dir})
	# add_library(.. STATIC ..) 일 경우, target_link_libraries(any_link_type) 는 output_static_lib 에 영향을 주지 않음
	# TODO: botan_static_lib 을 포함 하는 moran_static 생성

	#-----------------------------------------------------------------------------------------------
	# [2] build shared-library: link botan-static-library (recommend)
	#-----------------------------------------------------------------------------------------------
	add_library(moran_shared_lib SHARED moran.cpp)
	if(MSVC)
		target_compile_definitions(moran_shared_lib PRIVATE MSVC_SHARED_LIB)
	endif()
	set_target_properties(moran_shared_lib PROPERTIES OUTPUT_NAME ${moran_shared_lib_output_name})
	target_include_directories(moran_shared_lib PRIVATE ${botan_include_dir})
	target_link_libraries(moran_shared_lib PRIVATE ${botan_static_lib_filepath})

endif()

if(UNIX OR (MSVC AND botan_home_shared))
	if(MSVC AND botan_home_shared)
		set(botan_include_dir "${CMAKE_SOURCE_DIR}/${botan_home_shared}/build/include")
	endif()

	#-----------------------------------------------------------------------------------------------
	# [3] build shared-library: link botan-shared-library
	#-----------------------------------------------------------------------------------------------
	add_library(moran_shared_lib_depend_botan SHARED moran.cpp)
	if(MSVC)
		target_compile_definitions(moran_shared_lib_depend_botan PRIVATE MSVC_SHARED_LIB)
	endif()
	set_target_properties(moran_shared_lib_depend_botan PROPERTIES OUTPUT_NAME "${moran_shared_lib_output_name}_depend_botan")
	target_include_directories(moran_shared_lib_depend_botan PRIVATE ${botan_include_dir})
	target_link_directories(moran_shared_lib_depend_botan PRIVATE ${botan_shared_library_dir})
	target_link_libraries(moran_shared_lib_depend_botan PRIVATE ${botan_library_name})

endif()

