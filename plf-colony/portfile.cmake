vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO mattreecebentley/plf_colony
	REF 14c2f274b297c95c0caec637f40d358ecd53d838
	SHA512 4dcca20bf8e2353bf6f7d3d24241672d3cee529bf93729e1b463193918728f081d0da88af35b9e0caa4a2dce675f367ac2c8ef12e68c0b930d92527c66912ced
	HEAD_REF master
)

file(INSTALL ${SOURCE_PATH}/plf_colony.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
