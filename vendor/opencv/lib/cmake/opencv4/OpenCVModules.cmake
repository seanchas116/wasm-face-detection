# Generated by CMake

if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.5)
   message(FATAL_ERROR "CMake >= 2.6.0 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.6)
#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Protect against multiple inclusion, which would fail when already imported targets are added once more.
set(_targetsDefined)
set(_targetsNotDefined)
set(_expectedTargets)
foreach(_expectedTarget zlib libprotobuf opencv_core opencv_flann opencv_imgproc opencv_phase_unwrapping opencv_photo opencv_plot opencv_reg opencv_surface_matching opencv_xphoto opencv_bioinspired opencv_features2d opencv_fuzzy opencv_hfs opencv_img_hash opencv_imgcodecs opencv_line_descriptor opencv_saliency opencv_calib3d opencv_objdetect opencv_rgbd opencv_structured_light opencv_video opencv_xfeatures2d opencv_ximgproc opencv_xobjdetect opencv_aruco opencv_bgsegm opencv_dpm opencv_face opencv_optflow opencv_tracking opencv_stereo)
  list(APPEND _expectedTargets ${_expectedTarget})
  if(NOT TARGET ${_expectedTarget})
    list(APPEND _targetsNotDefined ${_expectedTarget})
  endif()
  if(TARGET ${_expectedTarget})
    list(APPEND _targetsDefined ${_expectedTarget})
  endif()
endforeach()
if("${_targetsDefined}" STREQUAL "${_expectedTargets}")
  unset(_targetsDefined)
  unset(_targetsNotDefined)
  unset(_expectedTargets)
  set(CMAKE_IMPORT_FILE_VERSION)
  cmake_policy(POP)
  return()
endif()
if(NOT "${_targetsDefined}" STREQUAL "")
  message(FATAL_ERROR "Some (but not all) targets in this export set were already defined.\nTargets Defined: ${_targetsDefined}\nTargets not yet defined: ${_targetsNotDefined}\n")
endif()
unset(_targetsDefined)
unset(_targetsNotDefined)
unset(_expectedTargets)


# Compute the installation prefix relative to this file.
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
if(_IMPORT_PREFIX STREQUAL "/")
  set(_IMPORT_PREFIX "")
endif()

# Create imported target zlib
add_library(zlib STATIC IMPORTED)

# Create imported target libprotobuf
add_library(libprotobuf STATIC IMPORTED)

# Create imported target opencv_core
add_library(opencv_core STATIC IMPORTED)

set_target_properties(opencv_core PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:zlib>"
)

# Create imported target opencv_flann
add_library(opencv_flann STATIC IMPORTED)

set_target_properties(opencv_flann PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;opencv_core"
)

# Create imported target opencv_imgproc
add_library(opencv_imgproc STATIC IMPORTED)

set_target_properties(opencv_imgproc PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;opencv_core"
)

# Create imported target opencv_phase_unwrapping
add_library(opencv_phase_unwrapping STATIC IMPORTED)

set_target_properties(opencv_phase_unwrapping PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_imgproc>;opencv_core;opencv_imgproc"
)

# Create imported target opencv_photo
add_library(opencv_photo STATIC IMPORTED)

set_target_properties(opencv_photo PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_imgproc>;opencv_core;opencv_imgproc"
)

# Create imported target opencv_plot
add_library(opencv_plot STATIC IMPORTED)

set_target_properties(opencv_plot PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_imgproc>;opencv_core;opencv_imgproc"
)

# Create imported target opencv_reg
add_library(opencv_reg STATIC IMPORTED)

set_target_properties(opencv_reg PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_imgproc>;opencv_core;opencv_imgproc"
)

# Create imported target opencv_surface_matching
add_library(opencv_surface_matching STATIC IMPORTED)

set_target_properties(opencv_surface_matching PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;opencv_core;opencv_flann"
)

# Create imported target opencv_xphoto
add_library(opencv_xphoto STATIC IMPORTED)

set_target_properties(opencv_xphoto PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_photo>;opencv_core;opencv_imgproc;opencv_photo"
)

# Create imported target opencv_bioinspired
add_library(opencv_bioinspired STATIC IMPORTED)

set_target_properties(opencv_bioinspired PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;opencv_core"
)

# Create imported target opencv_features2d
add_library(opencv_features2d STATIC IMPORTED)

set_target_properties(opencv_features2d PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;opencv_core;opencv_flann;opencv_imgproc"
)

# Create imported target opencv_fuzzy
add_library(opencv_fuzzy STATIC IMPORTED)

set_target_properties(opencv_fuzzy PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_imgproc>;opencv_core;opencv_imgproc"
)

# Create imported target opencv_hfs
add_library(opencv_hfs STATIC IMPORTED)

set_target_properties(opencv_hfs PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_imgproc>;opencv_core;opencv_imgproc"
)

# Create imported target opencv_img_hash
add_library(opencv_img_hash STATIC IMPORTED)

set_target_properties(opencv_img_hash PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_imgproc>;opencv_core;opencv_imgproc"
)

# Create imported target opencv_imgcodecs
add_library(opencv_imgcodecs STATIC IMPORTED)

set_target_properties(opencv_imgcodecs PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_imgproc>;opencv_core;opencv_imgproc"
)

# Create imported target opencv_line_descriptor
add_library(opencv_line_descriptor STATIC IMPORTED)

set_target_properties(opencv_line_descriptor PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_features2d>;opencv_core;opencv_flann;opencv_imgproc;opencv_features2d"
)

# Create imported target opencv_saliency
add_library(opencv_saliency STATIC IMPORTED)

set_target_properties(opencv_saliency PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_features2d>;opencv_core;opencv_flann;opencv_imgproc;opencv_features2d"
)

# Create imported target opencv_calib3d
add_library(opencv_calib3d STATIC IMPORTED)

set_target_properties(opencv_calib3d PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_features2d>;opencv_core;opencv_flann;opencv_imgproc;opencv_features2d"
)

# Create imported target opencv_objdetect
add_library(opencv_objdetect STATIC IMPORTED)

set_target_properties(opencv_objdetect PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_calib3d>;opencv_core;opencv_flann;opencv_imgproc;opencv_features2d;opencv_calib3d"
)

# Create imported target opencv_rgbd
add_library(opencv_rgbd STATIC IMPORTED)

set_target_properties(opencv_rgbd PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_calib3d>;opencv_core;opencv_flann;opencv_imgproc;opencv_features2d;opencv_calib3d"
)

# Create imported target opencv_structured_light
add_library(opencv_structured_light STATIC IMPORTED)

set_target_properties(opencv_structured_light PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_phase_unwrapping>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_calib3d>;opencv_core;opencv_flann;opencv_imgproc;opencv_phase_unwrapping;opencv_features2d;opencv_calib3d"
)

# Create imported target opencv_video
add_library(opencv_video STATIC IMPORTED)

set_target_properties(opencv_video PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_calib3d>;opencv_core;opencv_flann;opencv_imgproc;opencv_features2d;opencv_calib3d"
)

# Create imported target opencv_xfeatures2d
add_library(opencv_xfeatures2d STATIC IMPORTED)

set_target_properties(opencv_xfeatures2d PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_calib3d>;opencv_core;opencv_flann;opencv_imgproc;opencv_features2d;opencv_calib3d"
)

# Create imported target opencv_ximgproc
add_library(opencv_ximgproc STATIC IMPORTED)

set_target_properties(opencv_ximgproc PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_imgcodecs>;\$<LINK_ONLY:opencv_calib3d>;\$<LINK_ONLY:opencv_video>;opencv_core;opencv_flann;opencv_imgproc;opencv_features2d;opencv_imgcodecs;opencv_calib3d;opencv_video"
)

# Create imported target opencv_xobjdetect
add_library(opencv_xobjdetect STATIC IMPORTED)

set_target_properties(opencv_xobjdetect PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_imgcodecs>;\$<LINK_ONLY:opencv_calib3d>;\$<LINK_ONLY:opencv_objdetect>;opencv_core;opencv_flann;opencv_imgproc;opencv_features2d;opencv_imgcodecs;opencv_calib3d;opencv_objdetect"
)

# Create imported target opencv_aruco
add_library(opencv_aruco STATIC IMPORTED)

set_target_properties(opencv_aruco PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_calib3d>;opencv_core;opencv_flann;opencv_imgproc;opencv_features2d;opencv_calib3d"
)

# Create imported target opencv_bgsegm
add_library(opencv_bgsegm STATIC IMPORTED)

set_target_properties(opencv_bgsegm PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_calib3d>;\$<LINK_ONLY:opencv_video>;opencv_core;opencv_flann;opencv_imgproc;opencv_features2d;opencv_calib3d;opencv_video"
)

# Create imported target opencv_dpm
add_library(opencv_dpm STATIC IMPORTED)

set_target_properties(opencv_dpm PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_calib3d>;\$<LINK_ONLY:opencv_objdetect>;opencv_core;opencv_flann;opencv_imgproc;opencv_features2d;opencv_calib3d;opencv_objdetect"
)

# Create imported target opencv_face
add_library(opencv_face STATIC IMPORTED)

set_target_properties(opencv_face PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_photo>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_calib3d>;\$<LINK_ONLY:opencv_objdetect>;opencv_core;opencv_flann;opencv_imgproc;opencv_photo;opencv_features2d;opencv_calib3d;opencv_objdetect"
)

# Create imported target opencv_optflow
add_library(opencv_optflow STATIC IMPORTED)

set_target_properties(opencv_optflow PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_imgcodecs>;\$<LINK_ONLY:opencv_calib3d>;\$<LINK_ONLY:opencv_video>;\$<LINK_ONLY:opencv_ximgproc>;opencv_core;opencv_flann;opencv_imgproc;opencv_features2d;opencv_imgcodecs;opencv_calib3d;opencv_video;opencv_ximgproc"
)

# Create imported target opencv_tracking
add_library(opencv_tracking STATIC IMPORTED)

set_target_properties(opencv_tracking PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_plot>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_calib3d>;\$<LINK_ONLY:opencv_video>;opencv_core;opencv_flann;opencv_imgproc;opencv_plot;opencv_features2d;opencv_calib3d;opencv_video"
)

# Create imported target opencv_stereo
add_library(opencv_stereo STATIC IMPORTED)

set_target_properties(opencv_stereo PROPERTIES
  INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:opencv_core>;\$<LINK_ONLY:opencv_flann>;\$<LINK_ONLY:opencv_imgproc>;\$<LINK_ONLY:opencv_plot>;\$<LINK_ONLY:opencv_features2d>;\$<LINK_ONLY:opencv_calib3d>;\$<LINK_ONLY:opencv_video>;\$<LINK_ONLY:opencv_tracking>;opencv_core;opencv_flann;opencv_imgproc;opencv_plot;opencv_features2d;opencv_calib3d;opencv_video;opencv_tracking"
)

if(CMAKE_VERSION VERSION_LESS 2.8.12)
  message(FATAL_ERROR "This file relies on consumers using CMake 2.8.12 or greater.")
endif()

# Load information for each installed configuration.
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
file(GLOB CONFIG_FILES "${_DIR}/OpenCVModules-*.cmake")
foreach(f ${CONFIG_FILES})
  include(${f})
endforeach()

# Cleanup temporary variables.
set(_IMPORT_PREFIX)

# Loop over all imported files and verify that they actually exist
foreach(target ${_IMPORT_CHECK_TARGETS} )
  foreach(file ${_IMPORT_CHECK_FILES_FOR_${target}} )
    if(NOT EXISTS "${file}" )
      message(FATAL_ERROR "The imported target \"${target}\" references the file
   \"${file}\"
but this file does not exist.  Possible reasons include:
* The file was deleted, renamed, or moved to another location.
* An install or uninstall procedure did not complete successfully.
* The installation package was faulty and contained
   \"${CMAKE_CURRENT_LIST_FILE}\"
but not all the files it references.
")
    endif()
  endforeach()
  unset(_IMPORT_CHECK_FILES_FOR_${target})
endforeach()
unset(_IMPORT_CHECK_TARGETS)

# This file does not depend on other imported targets which have
# been exported from the same project but in a separate export set.

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)
