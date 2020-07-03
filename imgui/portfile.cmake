# Example portfile skeleton, copy to ports tree & modify accordingly

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

set(REPO_PATH https://github.com/ocornut/imgui.git)
set(REPO_TAG fc9d6b6cb5956eb5a07e09c1d5e4685b1037109e)

include($ENV{VCPKG_PORT_LOOKUP_SCRIPT} OPTIONAL RESULT_VARIABLE USE_DEVELOPMENT_PORT)

if(USE_DEVELOPMENT_PORT)
	vcpkg_developer_port_redirect(${PORT})
	if(${PORT}_SOURCE_PATH)
		set(SOURCE_PATH ${${PORT}_SOURCE_PATH})
	endif()
endif()

if(NOT SOURCE_PATH)
	set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})
	
	if(USE_DEVELOPMENT_PORT)
		vcpkg_developer_repo_redirect(${PORT})
		
		if(${PORT}_REPO_PATH)
			set(REPO_PATH ${${PORT}_REPO_PATH})
		endif()
		
		if(${PORT}_REPO_TAG)
			set(REPO_TAG ${${PORT}_REPO_TAG})
		endif()
	endif()

	# Pull from git
	if(NOT EXISTS "${SOURCE_PATH}/.git")
		message(STATUS "Cloning and fetching submodules into ${SOURCE_PATH}")
		
		vcpkg_execute_required_process(
			COMMAND ${GIT} clone --depth 1 --branch ${REPO_TAG}	${REPO_PATH} ${SOURCE_PATH}
			WORKING_DIRECTORY ${SOURCE_PATH}
			LOGNAME clone
		)
	endif()
endif()

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

#vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
#    dx11_bindings    IMGUI_USE_DX11_BINDINGS
#    dx12_bindings    IMGUI_USE_DX12_BINDINGS
#)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
	OPTIONS
		-DVCPKG_DEVELOP_IS_PORT=ON
		-DVCPKG_DEVELOP_ROOT_DIR=$ENV{VCPKG_ROOT_DIR}
		-DVCPKG_DEVELOP_EZ_DIR=$ENV{VCPKG_EZ_DIR}
		-DVCPKG_DEVELOP_DIR=$ENV{VCPKG_DIR}
		-DVCPKG_PORTS_DEVELOP_DIR=$ENV{VCPKG_PORTS_DIR}
		-DVCPKG_DEVELOP_TRIPLET=$ENV{VCPKG_TRIPLET}
		-DIMGUI_USE_DX11_BINDINGS=ON
        #${FEATURE_OPTIONS}
    OPTIONS_DEBUG
        -DIMGUI_SKIP_HEADERS=ON
)

vcpkg_install_cmake()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

if(EXISTS "${CURRENT_PACKAGES_DIR}/lib/cmake/${PORT}")
    vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/${PORT})
elseif(EXISTS "${CURRENT_PACKAGES_DIR}/lib/${PORT}/cmake")
    vcpkg_fixup_cmake_targets(CONFIG_PATH lib/${PORT}/cmake)
endif()

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)