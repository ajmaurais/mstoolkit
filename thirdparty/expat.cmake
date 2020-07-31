
include(ExternalProject)

set(EXPAT_PREFIX expat-2.2.9)

set(EXPAT_URL ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/expat-2.2.9.tar.gz)

set(EXPAT_URL_MD5 077b953cc38df8fed78e92841cc35443)

set(EXPAT_SRC_BASE ${CMAKE_CURRENT_BINARY_DIR}/${EXPAT_PREFIX}) 

ExternalProject_Add(${EXPAT_PREFIX}
	PREFIX ${EXPAT_PREFIX}
	URL ${EXPAT_URL}
	URL_MD5 ${EXPAT_URL_MD5}
	# SOURCE_DIR ${EXPAT_SRC_BASE}
		BUILD_IN_SOURCE 1
		LOG_DOWNLOAD 0
		LOG_BUILD 0
		CONFIGURE_COMMAND ${EXPAT_SRC_BASE}/src/${EXPAT_PREFIX}/configure --prefix=${CMAKE_CURRENT_BINARY_DIR}
			--without-xmlwf --without-examples --without-tests
			--with-aix-soname=both
			--includedir ${CMAKE_CURRENT_BINARY_DIR}/include --libdir ${CMAKE_CURRENT_BINARY_DIR}/lib 
		BUILD_COMMAND make install	
		# STAMP_DIR ${EXPAT_SRC_BASE}/log
)

set(${EXPAT_PREFIX}_LIBRARY ${CMAKE_CURRENT_SOURCE_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}z${CMAKE_STATIC_LIBRARY_SUFFIX})
set(${EXPAT_PREFIX}_INCLUDE ${CMAKE_CURRENT_SOURCE_DIR}/include)

ExternalProject_Get_Property(${TBB_PREFIX} SOURCE_DIR)
message(STATUS "Source directory of ${TBB_PREFIX} ${SOURCE_DIR}")

