
#---------------------------------------------------------------------------------------------------
# build moran library
#---------------------------------------------------------------------------------------------------
set(botan_include_dir "${CMAKE_SOURCE_DIR}/${botan_home}/build/include")    # 상대경로 사용가능
set(botan_library_dir "${CMAKE_SOURCE_DIR}/${botan_home}")                  # 상대경로 사용가능 (static 링킹시에는 full-path 절대경로 필요)
if(MSVC)
	set(botan_library_name "botan")
	set(botan_static_lib_filename "${botan_library_name}.lib")
else()
	set(botan_library_name "botan-2")
	set(botan_static_lib_filename "${botan_library_name}.a")
endif()

#---------------------------------------------------------------------------------------------------
# test build with using botan-api
add_subdirectory(botan-test)

if(UNIX OR (NOT MINGW) OR botan_home_shared)
	if(botan_home_shared)	# MSVC
		set(botan_include_dir "${CMAKE_SOURCE_DIR}/${botan_home_shared}/build/include")
		set(botan_library_dir "${CMAKE_SOURCE_DIR}/${botan_home_shared}")
	endif()

	# build shared-library with botan-shared-library
	add_library(moran_shared_lib_botan-shared SHARED moran.cpp moran.h)
#	set_target_properties(moran_shared_lib_botan-shared PROPERTIES OUTPUT_NAME "moran")
	target_include_directories(moran_shared_lib_botan-shared PRIVATE ${botan_include_dir})
	target_link_directories(moran_shared_lib_botan-shared PRIVATE ${botan_library_dir})
	target_link_libraries(moran_shared_lib_botan-shared PRIVATE "botan")

	# build static-library with botan-shared-library
	add_library(moran_static_lib_botan-shared STATIC moran.cpp moran.h)
#	set_target_properties(moran_static_lib_botan-shared PROPERTIES OUTPUT_NAME "moran")
	target_include_directories(moran_static_lib_botan-shared PRIVATE ${botan_include_dir})
	target_link_directories(moran_static_lib_botan-shared PRIVATE ${botan_library_dir})
	target_link_libraries(moran_static_lib_botan-shared PRIVATE "botan")
endif()

if(UNIX OR MINGW OR botan_home_static)
	if(botan_home_static)	# MSVC
		set(botan_include_dir "${CMAKE_SOURCE_DIR}/${botan_home_static}/build/include")
		set(botan_library_dir "${CMAKE_SOURCE_DIR}/${botan_home_static}")
		message("${botan_library_dir}/${botan_static_lib_filename}")
		message("${botan_library_dir}/${botan_static_lib_filename}")
		message("${botan_library_dir}/${botan_static_lib_filename}")
	endif()

	# build shared-library with botan-static-library (recommend)
	add_library(moran_shared_lib_botan-static SHARED moran.cpp moran.h)
#	set_target_properties(moran_shared_lib_botan-static PROPERTIES OUTPUT_NAME "moran")
	target_include_directories(moran_shared_lib_botan-static PRIVATE ${botan_include_dir})
	target_link_libraries(moran_shared_lib_botan-static PRIVATE "${botan_library_dir}/${botan_static_lib_filename}")

	# build static-library with botan-static-library
	add_library(moran_static_lib_botan-static STATIC moran.cpp moran.h)
#	set_target_properties(moran_static_lib_botan-static PROPERTIES OUTPUT_NAME "moran")
	target_include_directories(moran_static_lib_botan-static PRIVATE ${botan_include_dir})
	target_link_libraries(moran_static_lib_botan-static PRIVATE "${botan_library_dir}/${botan_static_lib_filename}")
endif()

add_executable(sample-cpp_shared-shared sample-cpp.cpp)
target_link_libraries(sample-cpp_shared-shared PRIVATE moran_shared_lib_botan-shared)

add_executable(sample-cpp_static-shared sample-cpp.cpp)		# err
target_link_directories(sample-cpp_static-shared PRIVATE "${CMAKE_SOURCE_DIR}/${botan_home_shared}")
target_link_libraries(sample-cpp_static-shared PRIVATE moran_static_lib_botan-shared)

add_executable(sample-cpp_shared-static sample-cpp.cpp)
target_link_libraries(sample-cpp_shared-static PRIVATE moran_shared_lib_botan-static)

add_executable(sample-cpp_static-static sample-cpp.cpp)		# err
target_link_libraries(sample-cpp_static-static PRIVATE moran_static_lib_botan-static)



#------------------
# test lib, exe
#------------------

add_executable(texe texe.cpp)
target_link_libraries(texe PRIVATE tlib)

add_library(tlib STATIC tlib.cpp tlib.h)
