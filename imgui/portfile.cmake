vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ocornut/imgui
    HEAD_REF docking
	REF 4f5aac319e3561284833db90f35d218de8b282c1
    SHA512 77c84dcf63b1921c7bb644393bd6fd1916c5495119f438a555308ba8ab36001a10ed927d52ade8d882126fd00c6688f4f22e621c7909dc6998f1e1ab73ca10c5
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_check_features(
	OUT_FEATURE_OPTIONS 
		FEATURE_OPTIONS
	FEATURES
		dx12_bindings    IMGUI_USE_DX12_BINDINGS
	INVERTED_FEATURES
		dx12_bindings    IMGUI_USE_DX11_BINDINGS
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        ${FEATURE_OPTIONS}
    OPTIONS_DEBUG
        -DIMGUI_SKIP_HEADERS=ON
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets()

file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)