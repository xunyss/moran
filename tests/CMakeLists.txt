
add_executable(sample-cpp_shared-shared sample-cpp.cpp)
target_link_libraries(sample-cpp_shared-shared PRIVATE moran_shared_lib_botan-shared)

add_executable(sample-cpp_static-shared sample-cpp.cpp)
target_link_directories(sample-cpp_static-shared PRIVATE "${CMAKE_SOURCE_DIR}/${botan_home_shared}")
target_link_libraries(sample-cpp_static-shared PRIVATE moran_static_lib_botan-shared)

add_executable(sample-cpp_shared-static sample-cpp.cpp)
target_link_libraries(sample-cpp_shared-static PRIVATE moran_shared_lib_botan-static)

add_executable(sample-cpp_static-static sample-cpp.cpp)
target_link_libraries(sample-cpp_static-static PRIVATE moran_static_lib_botan-static)

add_executable(example sample-c.c)
target_link_directories(example PRIVATE "${CMAKE_SOURCE_DIR}/${botan_home_shared}")
target_link_libraries(example PRIVATE moran_static_lib_botan-shared)

