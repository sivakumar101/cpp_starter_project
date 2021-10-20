SOURCE_PACKAGE=gva_core_sdk.tar.gz
DOCKER_TAGS=build_src build_env 
DOCKER=docker
DOCKER_BUILD_ARGS=
DOCKER_ARGS=

all : build_src

# Package the source so that we can build it in the build_source_package target.
${SOURCE_PACKAGE} : 
	git archive -o ${SOURCE_PACKAGE} HEAD

build_env :
	${DOCKER} ${DOCKER_ARGS} build ${DOCKER_BUILD_ARGS} -t build_env --target build_machine .

build_src : build_env ${SOURCE_PACKAGE} 
	${DOCKER} ${DOCKER_ARGS} build ${DOCKER_BUILD_ARGS} -t build_src --target build_source_package .

clean:
	rm -f ${SOURCE_PACKAGE}
	${DOCKER} ${DOCKER_ARGS} rmi -f ${DOCKER_TAGS}

distclean: clean
	${DOCKER} ${DOCKER_ARGS} image prune

.PHONY: all ${DOCKER_TAGS}

