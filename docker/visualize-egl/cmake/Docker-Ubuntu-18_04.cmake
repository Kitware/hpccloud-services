
# Where should ParaView get installed
set(CMAKE_INSTALL_PREFIX "/ParaView" CACHE PATH "")

# Where will superbuild download its source tarballs
set(superbuild_download_location "/home/demo/pvsb/downloads" CACHE PATH "")

# How do we get ParaView
message("Using paraview git tag: $ENV{PARAVIEW_TAG}")
set(paraview_FROM_GIT ON CACHE BOOL "")
set(paraview_GIT_TAG $ENV{PARAVIEW_TAG} CACHE STRING "")
set(paraview_SOURCE_SELECTION git CACHE STRING "")

set(ENABLE_egl ON CACHE BOOL "")
set(USE_SYSTEM_egl ON CACHE BOOL "")
set(EGL_INCLUDE_DIR "/usr/include" CACHE PATH "")
set(EGL_LIBRARY "/usr/lib/x86_64-linux-gnu/libEGL.so" CACHE FILEPATH "")
set(EGL_gldispatch_LIBRARY "/usr/lib/x86_64-linux-gnu/libGLdispatch.so" CACHE FILEPATH "")
set(EGL_opengl_LIBRARY "/usr/lib/x86_64-linux-gnu/libOpenGL.so" CACHE FILEPATH "")

# Turn off index as it doesn't seem to work
set(ENABLE_nvidiaindex OFF CACHE BOOL "")
set(ENABLE_visrtx OFF CACHE BOOL "")

set(PV_CMAKE_ARGS "-DOpenGL_GL_PREFERENCE:STRING=GLVND")

# General rendering/graphics options
set(ENABLE_mesa OFF CACHE BOOL "")
set(PARAVIEW_DEFAULT_SYSTEM_GL OFF CACHE BOOL "")

# Some general options
set(BUILD_SHARED_LIBS ON CACHE BOOL "")
set(CMAKE_BUILD_TYPE Release CACHE STRING "")
set(BUILD_TESTING ON CACHE BOOL "")

# ParaView related
set(ENABLE_paraview ON CACHE BOOL "")
set(ENABLE_paraviewweb ON CACHE BOOL "")
set(ENABLE_paraviewgettingstartedguide OFF CACHE BOOL "")
set(ENABLE_paraviewtutorial OFF CACHE BOOL "")
set(ENABLE_paraviewusersguide OFF CACHE BOOL "")
set(ENABLE_paraviewtutorialdata OFF CACHE BOOL "")

# Python related
set(PV_CMAKE_ARGS "${PV_CMAKE_ARGS};-DPARAVIEW_PYTHON_VERSION:STRING=2")
set(PV_CMAKE_ARGS "${PV_CMAKE_ARGS};-DPython2_EXECUTABLE:FILEPATH=/usr/bin/python2")
set(PV_CMAKE_ARGS "${PV_CMAKE_ARGS};-DPython2_LIBRARY_RELEASE:FILEPATH=/usr/lib/x86_64-linux-gnu/libpython2.7.so")
set(PV_CMAKE_ARGS "${PV_CMAKE_ARGS};-DPython2_INCLUDE_DIR:PATH=/usr/include/python2.7")

set(ENABLE_python2 ON CACHE BOOL "")
set(USE_SYSTEM_python2 ON CACHE BOOL "")
set(ENABLE_python3 OFF CACHE BOOL "")
set(USE_SYSTEM_python3 OFF CACHE BOOL "")
set(USE_SYSTEM_pythonsetuptools ON CACHE BOOL "")
set(ENABLE_matplotlib ON CACHE BOOL "")
set(ENABLE_scipy ON CACHE BOOL "")

# VTK-m related
set(ENABLE_vtkm ON CACHE BOOL "")
set(vtkm_SOURCE_SELECTION for-git CACHE STRING "")

# Disable Qt5 stuff
set(ENABLE_qt5 OFF CACHE BOOL "")
set(USE_SYSTEM_qt5 OFF CACHE BOOL "")

# Other options
set(ENABLE_ospray ON CACHE BOOL "")
set(ENABLE_netcdf OFF CACHE BOOL "")
set(ENABLE_hdf5 ON CACHE BOOL "")
set(ENABLE_szip ON CACHE BOOL "")
set(ENABLE_visitbridge ON CACHE BOOL "")
set(ENABLE_ffmpeg ON CACHE BOOL "")
set(ENABLE_vistrails ON CACHE BOOL "")
set(ENABLE_mpi ON CACHE BOOL "")
set(ENABLE_silo ON CACHE BOOL "")
set(ENABLE_xdmf3 ON CACHE BOOL "")
set(ENABLE_h5py ON CACHE BOOL "")
set(ENABLE_numpy ON CACHE BOOL "")
set(ENABLE_cosmotools ON CACHE BOOL "")
set(DIY_SKIP_SVN ON CACHE BOOL "")
set(ENABLE_glu ON CACHE BOOL "")
set(ENABLE_tbb ON CACHE BOOL "")
set(ENABLE_boost ON CACHE BOOL "")
set(ENABLE_vortexfinder2 OFF CACHE BOOL "")
set(USE_NONFREE_COMPONENTS ON CACHE BOOL "")
set(ENABLE_las ON CACHE BOOL "")
set(ENABLE_acusolve ON CACHE BOOL "")
set(ENABLE_fontconfig ON CACHE BOOL "")

# FIXME: We should be able to have these, but they didn't work at some point
set(ENABLE_vrpn OFF CACHE BOOL "")
set(ENABLE_boxlib OFF CACHE BOOL "")

set(CTEST_USE_LAUNCHERS TRUE CACHE BOOL "")

set(PARAVIEW_EXTRA_CMAKE_ARGUMENTS "${PV_CMAKE_ARGS}" CACHE STRING "")
message("Set PARAVIEW_EXTRA_CMAKE_ARGUMENTS to ${PARAVIEW_EXTRA_CMAKE_ARGUMENTS}")
