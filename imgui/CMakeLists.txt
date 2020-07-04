cmake_minimum_required(VERSION 3.8)
project(imgui CXX)

set(CMAKE_DEBUG_POSTFIX d)

add_library(${PROJECT_NAME} "")
add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})
target_include_directories(
	${PROJECT_NAME}
	PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
		$<INSTALL_INTERFACE:include>
)

target_sources(
	${PROJECT_NAME}
	PRIVATE
		${CMAKE_CURRENT_SOURCE_DIR}/imgui.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/imgui_demo.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/imgui_draw.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/imgui_widgets.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/misc/cpp/imgui_stdlib.cpp
)

if(IMGUI_USE_DX11_BINDINGS)
	file(GLOB 
		IMGUI_BINDINGS 
			${CMAKE_CURRENT_SOURCE_DIR}/examples/imgui_impl_win32.h
			${CMAKE_CURRENT_SOURCE_DIR}/examples/imgui_impl_dx11.h
	)

	target_sources(
		${PROJECT_NAME}
		PRIVATE
			${CMAKE_CURRENT_SOURCE_DIR}/examples/imgui_impl_win32.cpp
			${CMAKE_CURRENT_SOURCE_DIR}/examples/imgui_impl_dx11.cpp
	)

	set(IMGUI_USE_ANY_BINDINGS ON)
endif()

if(IMGUI_USE_DX12_BINDINGS)
	file(GLOB 
		IMGUI_BINDINGS 
			${CMAKE_CURRENT_SOURCE_DIR}/examples/imgui_impl_win32.h
			${CMAKE_CURRENT_SOURCE_DIR}/examples/imgui_impl_dx12.h
	)

	target_sources(
		${PROJECT_NAME}
		PRIVATE
			${CMAKE_CURRENT_SOURCE_DIR}/examples/imgui_impl_win32.cpp
			${CMAKE_CURRENT_SOURCE_DIR}/examples/imgui_impl_dx12.cpp
	)

	set(IMGUI_USE_ANY_BINDINGS ON)
endif()

install(
	TARGETS ${PROJECT_NAME}
	EXPORT ${PROJECT_NAME}_target
	ARCHIVE DESTINATION lib
	LIBRARY DESTINATION lib
	RUNTIME DESTINATION bin
)

if(NOT IMGUI_SKIP_HEADERS)
    install(FILES
        ${CMAKE_CURRENT_SOURCE_DIR}/imgui.h
		${CMAKE_CURRENT_SOURCE_DIR}/imconfig.h
		${CMAKE_CURRENT_SOURCE_DIR}/imgui_internal.h
		${CMAKE_CURRENT_SOURCE_DIR}/imstb_rectpack.h
		${CMAKE_CURRENT_SOURCE_DIR}/imstb_textedit.h
		${CMAKE_CURRENT_SOURCE_DIR}/imstb_truetype.h
        ${CMAKE_CURRENT_SOURCE_DIR}/misc/cpp/imgui_stdlib.h
        DESTINATION include
    )

	if(IMGUI_USE_ANY_BINDINGS)
		install(
			FILES ${IMGUI_BINDINGS}

			DESTINATION include
		)
	endif()
endif()

install(
	EXPORT ${PROJECT_NAME}_target
	NAMESPACE ${PROJECT_NAME}::
	FILE ${PROJECT_NAME}-config.cmake
	DESTINATION share/${PROJECT_NAME}
)
