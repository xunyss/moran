
#===================================================================================================
# build example
#===================================================================================================
if(UNIX OR MINGW OR (MSVC AND botan_home_static))
	# [1]
	add_executable(sample-cpp_shared-static sample-cpp.cpp)
	target_link_libraries(sample-cpp_shared-static PRIVATE moran_shared_lib)				# link moran-shared-library

	# [2]
	add_executable(sample-cpp_static-static sample-cpp.cpp)
	target_link_libraries(sample-cpp_static-static PRIVATE moran_static_lib)				# link moran-static-library
	target_link_libraries(sample-cpp_static-static PRIVATE ${botan_static_lib_filepath})	# link botan-static-library

endif()

if(UNIX OR (MSVC AND botan_home_shared))
	# [3]
	add_executable(sample-cpp_shared-shared sample-cpp.cpp)
	target_link_libraries(sample-cpp_shared-shared PRIVATE moran_shared_lib_depend_botan)	# link moran-shared-library (depend on botan-shared-library)

	# [4]
	add_executable(sample-cpp_static-shared sample-cpp.cpp)
	target_link_libraries(sample-cpp_static-shared PRIVATE moran_static_lib)				# link moran-static-library
	target_link_libraries(sample-cpp_static-shared PRIVATE ${botan_library_name})			# link botan-shared-library
	target_link_directories(sample-cpp_static-shared PRIVATE ${botan_shared_library_dir})

endif()


# .c example
#add_executable(example sample-c.c)
#target_link_directories(example PRIVATE "${CMAKE_SOURCE_DIR}/${botan_home_shared}")
#target_link_libraries(example PRIVATE moran_static_lib_botan-shared)

