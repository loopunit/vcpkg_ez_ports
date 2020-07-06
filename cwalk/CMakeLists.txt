cmake_minimum_required(VERSION 3.8)

project(cwalk
  DESCRIPTION "A simple path library"
  LANGUAGES C
  VERSION 1.1.1)


set(CMAKE_DEBUG_POSTFIX d)

add_library(${PROJECT_NAME} "")
add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})
target_include_directories(
	${PROJECT_NAME}
	PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
		$<INSTALL_INTERFACE:include>
)

target_sources(
	${PROJECT_NAME}
	PRIVATE
		${CMAKE_CURRENT_SOURCE_DIR}/src/cwalk.c
)

install(
	TARGETS ${PROJECT_NAME}
	EXPORT ${PROJECT_NAME}_target
	ARCHIVE DESTINATION lib
	LIBRARY DESTINATION lib
	RUNTIME DESTINATION bin
)

install(FILES
	${CMAKE_CURRENT_SOURCE_DIR}/include/cwalk.h
	DESTINATION include
)

install(
	EXPORT ${PROJECT_NAME}_target
	NAMESPACE ${PROJECT_NAME}::
	FILE ${PROJECT_NAME}-config.cmake
	DESTINATION share/${PROJECT_NAME}
)

