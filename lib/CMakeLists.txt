
#---------------------------------------------------------------------------------------------------
# build moran library
#---------------------------------------------------------------------------------------------------
add_library(moran_shared SHARED moran.cpp moran.h)
set_target_properties(moran_shared PROPERTIES OUTPUT_NAME "moran")
target_include_directories(moran_shared PRIVATE "../${botan_include_dir}")
target_link_directories(moran_shared PRIVATE "../${botan_home}")
target_link_libraries(moran_shared PRIVATE "botan-2")

add_library(moran_static STATIC moran.cpp moran.h)
set_target_properties(moran_static PROPERTIES OUTPUT_NAME "moran")
target_include_directories(moran_static PRIVATE "../${botan_include_dir}")
target_link_directories(moran_static PRIVATE "../${botan_home}")
target_link_libraries(moran_static PRIVATE "botan-2")

