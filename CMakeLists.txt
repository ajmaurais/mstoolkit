cmake_minimum_required(VERSION 3.16)
project(mstoolkit)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_NOSQLITE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -DGCC -DHAVE_EXPAT_CONFIG_H")
set(LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
# set(MSTOOLKIT_STATIC_LIBS "z expat mzparser mzimltools mstoolkit")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/thirdparty")
include(zlib)
include(expat)

include_directories(include ${CMAKE_CURRENT_BINARY_DIR}/include)

# option(BUILD_LITE "Include sql in build?" OFF)
# if(BUILD_LITE MATCHES ON)
# 	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
# 	set(MSTOOLKIT_STATIC_LIBS "sqllite3 ${MSTOOLKIT_STATIC_LIBS}")
# 	file(GLOB SQLLITE_SRC "src/sqlite-3.32.1/*.c")
# 	add_library(sqllite3 STATIC ${SQLLITE_SRC})
# endif()

file(GLOB MSPARSER_SRC "src/mzParser/*.cpp")
file(GLOB MZIMLTOOLS_SRC "src/mzIMLTools/*.cpp")
file(GLOB MSTOOLKIT_SRC "src/MSToolkit/*.cpp")

option(BUILD_RAW_READER "Add ability to read Thermo .raw files? (Windows only) OFF")
if(BUILD_RAW_READER MATCHES OFF)
	list(FILTER MSTOOLKIT_SRC EXCLUDE REGEX "MSToolkit\/RAWReader.cpp$")
endif()

# add_library(mzparser STATIC ${MSPARSER_SRC})
# add_library(mzimltools STATIC ${MZIMLTOOLS_SRC})
# add_library(mstoolkit STATIC ${MSTOOLKIT_SRC})
add_library(mstoolkit STATIC ${MSPARSER_SRC} ${MSTOOLKIT_SRC} ${MZIMLTOOLS_SRC})
target_link_libraries(mstoolkit zlib expat)

add_executable(MSSingleScan "MSSingleScanSrc/MSSingleScan.cpp")
# target_link_libraries(MSSingleScan z expat mzparser mzimltools mstoolkit)
target_link_libraries(MSSingleScan mstoolkit)
