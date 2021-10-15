SOURCE_PACKAGE=gva_core_sdk.tar.gz
DOCKER_TAGS=deploy_env deploy_pkg build_src build_env 
DOCKER=docker
DOCKER_BUILD_ARGS=
DOCKER_ARGS=

all : deploy_pkg 

${SOURCE_PACKAGE} : 
	git archive -o ${SOURCE_PACKAGE} HEAD

deploy_env :
	${DOCKER} ${DOCKER_ARGS} build ${DOCKER_BUILD_ARGS} -t deploy_env --target deployment_env .

build_env :
	${DOCKER} ${DOCKER_ARGS} build ${DOCKER_BUILD_ARGS} -t build_env --target build_machine .

build_src : build_env ${SOURCE_PACKAGE} 
	${DOCKER} ${DOCKER_ARGS} build ${DOCKER_BUILD_ARGS} -t build_src --target build_source_package .

deploy_pkg : deploy_env build_src 
	${DOCKER} ${DOCKER_ARGS} build ${DOCKER_BUILD_ARGS} -t deploy_pkg --target deployment_package .

clean:
	rm -f ${SOURCE_PACKAGE}
	${DOCKER} ${DOCKER_ARGS} rmi -f ${DOCKER_TAGS}

distclean: clean
	${DOCKER} ${DOCKER_ARGS} image prune

.PHONY: all ${DOCKER_TAGS}

