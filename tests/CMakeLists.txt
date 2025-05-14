
if(UNIX OR (NOT MINGW) OR botan_home_shared)
    if(botan_home_shared)	# MSVC
        set(botan_library_dir "${CMAKE_SOURCE_DIR}/${botan_home_shared}")
    endif()
    # [1]
    add_executable(sample-cpp_shared-shared sample-cpp.cpp)
    target_link_libraries(sample-cpp_shared-shared PRIVATE moran_shared_lib_botan-shared)
    # [2]
    add_executable(sample-cpp_static-shared sample-cpp.cpp)
    target_link_directories(sample-cpp_static-shared PRIVATE "${botan_library_dir}")
    target_link_libraries(sample-cpp_static-shared PRIVATE moran_static_lib_botan-shared)
endif()
if(UNIX OR MINGW OR botan_home_static)
    # [3]
    add_executable(sample-cpp_shared-static sample-cpp.cpp)
    target_link_libraries(sample-cpp_shared-static PRIVATE moran_shared_lib_botan-static)
    # [4]
    add_executable(sample-cpp_static-static sample-cpp.cpp)
    target_link_libraries(sample-cpp_static-static PRIVATE moran_static_lib_botan-static)
endif()






add_executable(example sample-c.c)
target_link_directories(example PRIVATE "${CMAKE_SOURCE_DIR}/${botan_home_shared}")
target_link_libraries(example PRIVATE moran_static_lib_botan-shared)

