# Linux specific setting for the Opensplice libraries and headers.
# The application will be dynamically linking to the opensplice libraries.

if (UNIX)
FIND_PATH(OpenSplice_INCLUDE_DIR
NAMES
ccpp_dds_dcps.h
PATHS
$ENV{OSPL_HOME}/install/HDE/$ENV{SPLICE_TARGET}/include/dcps/C++/SACPP
)

SET(OpenSplice_INCLUDE_DIRS
$ENV{OSPL_HOME}/include
$ENV{OSPL_HOME}/include/sys
$ENV{OSPL_HOME}/include/dcps/C++/isocpp2
$ENV{OSPL_HOME}/etc/idl/
)

# Find all the required libraries
FIND_LIBRARY(DCPSGAPI_LIBRARY
NAMES
dcpsgapi
PATHS
$ENV{OSPL_HOME}/lib/$ENV{SPLICE_TARGET}
)

FIND_LIBRARY(DCPSSACPP_LIBRARY
NAMES
dcpssacpp
PATHS
$ENV{OSPL_HOME}/lib/$ENV{SPLICE_TARGET}
)

FIND_LIBRARY(DDSKERNEL_LIBRARY
NAMES
ddskernel
PATHS
$ENV{OSPL_HOME}/lib/$ENV{SPLICE_TARGET}
)

FIND_LIBRARY(DCPSISOCPP_LIBRARY
NAMES
dcpsisocpp2
PATHS
$ENV{OSPL_HOME}/lib/$ENV{SPLICE_TARGET}
)

FIND_LIBRARY(DDSDATABASE_LIBRARY
NAMES
ddsdatabase
PATHS
$ENV{OSPL_HOME}/lib/$ENV{SPLICE_TARGET}
)

FIND_LIBRARY(DDSOS_LIBRARY
NAMES
ddsos
PATHS
$ENV{OSPL_HOME}/lib/$ENV{SPLICE_TARGET}
)

SET(OpenSplice_LIBRARIES
${DCPSGAPI_LIBRARY}
${DCPSSACPP_LIBRARY}
${DDSDATABASE_LIBRARY}
${DDSOS_LIBRARY}
${DDSKERNEL_LIBRARY}
${DCPSISOCPP_LIBRARY}
)

# Set the IDLGEN binary in case if we plan to do the IDL to CPP conversion from the cmake.
SET (OpenSplice_IDLGEN_BINARY $ENV{OSPL_HOME}/bin/idlpp -I $ENV{OSPL_HOME}/etc/idlpp)

IF (OpenSplice_INCLUDE_DIRS AND OpenSplice_LIBRARIES)
SET(OpenSplice_FOUND TRUE)
ENDIF (OpenSplice_INCLUDE_DIRS AND OpenSplice_LIBRARIES)

IF (OpenSplice_FOUND)
MESSAGE(STATUS "Found Vortex OpenSplice libraries: ${OpenSplice_LIBRARIES}")
ELSE (OpenSplice_FOUND)
IF (OpenSplice_FIND_REQUIRED)
MESSAGE(FATAL_ERROR "Could not find Vortex OpenSplice")
ENDIF (OpenSplice_FIND_REQUIRED)
ENDIF (OpenSplice_FOUND)

MARK_AS_ADVANCED(OpenSplice_INCLUDE_DIRS OpenSplice_LIBRARIES OpenSplice_IDLGEN_BINARY)
endif()