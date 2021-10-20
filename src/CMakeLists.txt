# Add the source files to create a target which will be the shared library 
# of the GVA service resource.
# For the time being this is left empty as we have not got any source files 
# at the moment.

include_directories(
  ${PROJECT_SOURCE_DIR}
  ${OpenSplice_INCLUDE_DIRS}
)


#set (gva_sourcefiles {})
#set (GVA_SERVICE_RESOURCE gva_service_resource)
#add_library (${GVA_SERVICE_RESOURCE} SHARED ${gva_sourcefiles})

#target_link_libraries (${GVA_SERVICE_RESOURCE} 
#  ${OpenSplice_LIBRARIES} 
#  ${Boost_LIBRARIES} 
#  project_options 
#  project_warnings
#)

