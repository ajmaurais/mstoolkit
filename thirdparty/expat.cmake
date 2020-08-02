
add_library(expat INTERFACE)
set(EXPAT_VERSION "2.2.9")
find_package(expat ${EXPAT_VERSION})

if(NOT EXPAT_FOUND)
	include(ExternalProject)
	include(GNUInstallDirs)

	set(EXPAT_PREFIX "expat-${EXPAT_VERSION}")

	set(EXPAT_URL ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/expat-2.2.9.tar.gz)
	set(EXPAT_URL_MD5 077b953cc38df8fed78e92841cc35443)
	set(EXPAT_SRC_BASE ${CMAKE_CURRENT_BINARY_DIR}/${EXPAT_PREFIX}) 

	ExternalProject_Add(${EXPAT_PREFIX}
		PREFIX ${EXPAT_PREFIX}
		URL ${EXPAT_URL}
		URL_MD5 ${EXPAT_URL_MD5}
		BUILD_IN_SOURCE 1
		LOG_DOWNLOAD 0
		LOG_BUILD 0
		CONFIGURE_COMMAND ${EXPAT_SRC_BASE}/src/${EXPAT_PREFIX}/configure --prefix=${CMAKE_CURRENT_BINARY_DIR}
			--without-xmlwf --without-examples --without-tests
			--with-aix-soname=both
			--includedir ${CMAKE_CURRENT_BINARY_DIR}/include --libdir ${CMAKE_CURRENT_BINARY_DIR}/lib 
		BUILD_COMMAND make install
		)

	add_dependencies(expat expat_external)
	set(EXPAT_LIBRARY ${LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_STATIC_LIBRARY_PREFIX}expat${CMAKE_STATIC_LIBRARY_SUFFIX})
	set(EXPAT_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)
endif()

target_link_libraries(expat INTERFACE ${EXPAT_LIBRARY})
target_include_directories(expat INTERFACE ${EXPAT_INCLUDE_DIR})

