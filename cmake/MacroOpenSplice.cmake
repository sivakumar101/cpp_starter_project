# Macro to create a list with all the generated source files for a given .idl filename
MACRO (DEFINE_OpenSplice_SOURCES idlfilename)
	SET(outsources)
	GET_FILENAME_COMPONENT(it ${idlfilename} ABSOLUTE)
	GET_FILENAME_COMPONENT(nfile ${idlfilename} NAME_WE)
	SET(outsources ${outsources} ${nfile}.cpp ${nfile}.h)
	SET(outsources ${outsources} ${nfile}SplDcps.cpp ${nfile}SplDcps.h)
	SET(outsources ${outsources} ${nfile}_Dcps.cpp ${nfile}_Dcps.hpp)	
ENDMACRO(DEFINE_OpenSplice_SOURCES)

MACRO (OpenSplice_IDLGEN idlfilename)
    GET_FILENAME_COMPONENT(it ${idlfilename} ABSOLUTE)
    GET_FILENAME_COMPONENT(idlfilename ${idlfilename} NAME)

    DEFINE_OpenSplice_SOURCES(${ARGV})

    add_custom_command (OUTPUT  ${outsources}
        COMMAND ${OpenSplice_IDLGEN_BINARY}
        ARGS -l isocpp2 ${idlfilename}
        DEPENDS ${it}
        COMMAND echo "executing a fake command"
        COMMENT "a commant"
    )   
ENDMACRO (OpenSplice_IDLGEN)
