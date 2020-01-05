project(lciowrapper)

cmake_minimum_required(VERSION 2.8.12)
# this helps Libdl.dlopen find the right paths
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib;${LCIO_LIBRARY_DIRS};${Julia_LIBRARY_DIR}")
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
set(CMAKE_INSTALL_LIBDIR "lib")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
# Special setting for MacOS X
set(CMAKE_MACOSX_RPATH 1)

if(MSVC)
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY  "${CMAKE_BINARY_DIR}/bin")
else()
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES "Intel")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wunused-parameter -Wextra -Wreorder")
endif()
set(CMAKE_CXX_STANDARD 17)
add_definitions(-DJULIA_ENABLE_THREADING)

find_package(LCIO REQUIRED)

# JlCxx_DIR needs to be passed in with -D
find_package(JlCxx REQUIRED )


include_directories(${CMAKE_SOURCE_DIR}/include)
include_directories(${INTERFACE_INCLUDE_DIRECTORIES})
include_directories(${LCIO_INCLUDE_DIRS})

add_library(lciowrap SHARED src/lciowrap.cc )
target_link_libraries(lciowrap ${LCIO_LCIO_LIBRARY} ${LCIO_SIO_LIBRARY} JlCxx::cxxwrap_julia JlCxx::cxxwrap_julia_stl)

install(TARGETS
  lciowrap
LIBRARY DESTINATION lib${LIBDIR_SUFFIX}
ARCHIVE DESTINATION lib${LIBDIR_SUFFIX}
RUNTIME DESTINATION lib${LIBDIR_SUFFIX}
INCLUDES DESTINATION include)
