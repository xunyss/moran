
#===================================================================================================
# build example
#===================================================================================================
if(UNIX OR MINGW OR (MSVC AND botan_home_static))

	# [1] moran-shared/botan-static: w/ moran-shared-library
	add_executable(ex_cpp_mo example.cpp)
	target_link_libraries(ex_cpp_mo PRIVATE moran_shared_lib)					# link moran-shared-library

	add_executable(ex_c_mo example.c)
	target_link_libraries(ex_c_mo PRIVATE moran_shared_lib)

	# [2] moran-static/botan-static: w/ nothing (standalone)
	add_executable(ex_cpp example.cpp)
	target_link_libraries(ex_cpp PRIVATE moran_static_lib)						# link moran-static-library
	target_link_libraries(ex_cpp PRIVATE ${botan_static_lib_filepath})			# link botan-static-library

	add_executable(ex_c example.c)
	target_link_libraries(ex_c PRIVATE moran_static_lib)
	target_link_libraries(ex_c PRIVATE ${botan_static_lib_filepath})

endif()

if(UNIX OR (MSVC AND botan_home_shared))

	# [3] moran-shared/botan-shared: w/ moran_shared_lib_depend_botan, botan-shared-library
	add_executable(ex_cpp_mobo example.cpp)
	target_link_libraries(ex_cpp_mobo PRIVATE moran_shared_lib_depend_botan)	# link moran_shared_lib_depend_botan

	add_executable(ex_c_mobo example.c)
	target_link_libraries(ex_c_mobo PRIVATE moran_shared_lib_depend_botan)

	# [4] moran-static/botan-shared: w/ botan-shared-library
	add_executable(ex_cpp_bo example.cpp)
	target_link_libraries(ex_cpp_bo PRIVATE moran_static_lib)					# link moran-static-library
	target_link_libraries(ex_cpp_bo PRIVATE ${botan_library_name})				# link botan-shared-library
	target_link_directories(ex_cpp_bo PRIVATE ${botan_shared_library_dir})

	add_executable(ex_c_bo example.c)
	target_link_libraries(ex_c_bo PRIVATE moran_static_lib)
	target_link_libraries(ex_c_bo PRIVATE ${botan_library_name})
	target_link_directories(ex_c_bo PRIVATE ${botan_shared_library_dir})

endif()

