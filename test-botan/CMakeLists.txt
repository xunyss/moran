
#---------------------------------------------------------------------------------------------------
# build botan-test
#---------------------------------------------------------------------------------------------------
# botan-test (shared-lib link)
add_executable(test-botan-shared test-botan.cpp)
target_include_directories(test-botan-shared PRIVATE "../${botan_include_dir}")
#target_link_directories(test-botan-shared PRIVATE ${botan_library_dir})					# target_link_directories 로 경로를 지정(상대 경로 가능) 하고
#target_link_libraries(test-botan-shared PRIVATE "botan-2")									# target_link_libraries 함수로 library-name 만 명시할 경우 [default link type: shared]
target_link_libraries(test-botan-shared PRIVATE "${botan_library_dir}/libbotan-2.dylib")	# static type 으로 link 하려면 [library file 의 full-path(상대 경로 불가능) 명시 (recommended)]

# botan-test (static-lib link)
add_executable(test-botan-static test-botan.cpp)
target_include_directories(test-botan-static PRIVATE "../${botan_include_dir}")
target_link_libraries(test-botan-static PRIVATE "${botan_library_dir}/libbotan-2.a")

