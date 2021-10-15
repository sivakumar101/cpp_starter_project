FROM centos:centos8 as deployment_env 
ARG TZ=Australia/Canberra
ARG OSPL_RELDIR="OSPL_V6_9_210323OSS_RELEASE"
ARG OSPL_RELFILE="PXXX-VortexOpenSplice-6.9.210323OSS-HDE-x86_64.linux-gcc7-glibc2.27-installer.tar"

WORKDIR /project
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime

RUN dnf install -y wget
RUN dnf upgrade -y
RUN    dnf install -y gdb \
    && dnf install -y boost \
    && dnf install -y less 

RUN \
    wget -q https://github.com/ADLINK-IST/opensplice/releases/download/${OSPL_RELDIR}/${OSPL_RELFILE} && \
    tar -xf ${OSPL_RELFILE} -C /opt && \
    rm ${OSPL_RELFILE}

# Set up the DDS execution environment
ENV OSPL_HOME "/opt/HDE/x86_64.linux"
ENV OSPL_URI file:///opt/HDE/x86_64.linux/etc/config/ospl.xml
ENV LD_LIBRARY_PATH "$OSPL_HOME/lib${LD_LIBRARY_PATH:+:}$LD_LIBRARY_PATH"
ENV CPATH "$OSPL_HOME/include:$OSPL_HOME/include/sys${CPATH:+:}${CPATH}"
ENV PATH "$PATH:$OSPL_HOME/bin"

##################################################################
FROM deployment_env as build_machine

RUN    dnf install -y git  \
    && dnf install -y make  \
    && dnf install -y automake \
    && dnf install -y boost-devel \
    && dnf install -y less \
    && dnf install -y gcc \
    && dnf install -y gcc-c++ \
    && dnf install -y cmake
##################################################################

##################################################################

FROM build_machine as build_source_package
WORKDIR /project
ARG SOURCE_PACKAGE="gva_core_sdk.tar.gz"
ARG DESTINATION_DIR="gva_core_sdk"
COPY ${SOURCE_PACKAGE} ./${SOURCE_PACKAGE}
RUN mkdir -p ${DESTINATION_DIR}
RUN tar -xf ${SOURCE_PACKAGE} -C ./${DESTINATION_DIR}
RUN rm -f ${SOURCE_PACKAGE}
RUN cd ${DESTINATION_DIR} && mkdir build
RUN cd ${DESTINATION_DIR}/build && cmake ..
RUN cd ${DESTINATION_DIR}/build && make


##################################################################

FROM deployment_env as deployment_package
WORKDIR /project

# Copy the deployment package to the required path

