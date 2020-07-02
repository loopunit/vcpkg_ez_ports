# Distributed under the OSI-approved BSD 3-Clause License.

#.rst:
# FindMiniaudio
# ------------
#
# Find the Miniaudio include headers.
#
# Result Variables
# ^^^^^^^^^^^^^^^^
#
# This module defines the following variables:
#
# ``Miniaudio_FOUND``
#   True if Miniaudio library found
#
# ``Miniaudio_INCLUDE_DIR``
#   Location of Miniaudio headers
#

include(${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake)
include(${CMAKE_ROOT}/Modules/SelectLibraryConfigurations.cmake)

if(NOT Miniaudio_INCLUDE_DIR)
  find_path(Miniaudio_INCLUDE_DIR NAMES miniaudio.h PATHS ${Miniaudio_DIR} PATH_SUFFIXES include)
endif()

find_package_handle_standard_args(Miniaudio DEFAULT_MSG Miniaudio_INCLUDE_DIR)
mark_as_advanced(Miniaudio_INCLUDE_DIR)
