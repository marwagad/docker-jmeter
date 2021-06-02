 FROM egaillardon/jmeter:5.2.1-1.0.0
LABEL maintainer="emmanuel.gaillardon@orange.fr"
ENV JMETER_PLUGINS_MANAGER_VERSION 1.4
ENV CMDRUNNER_VERSION 2.2
ENV JSON_LIB_VERSION 2.4
ENV JSON_LIB_FULL_VERSION ${JSON_LIB_VERSION}-jdk15
ENV NUMBER_OF_FILES_UNDER_LIB 166
ENV NUMBER_OF_FILES_UNDER_LIB_EXT 81
RUN cd /tmp/ \

RUN wget -qO- http://ftp.ps.pl/pub/apache//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz | tar xvz && \
    wget -P ${JMETER_DIR}/lib/ext https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-manager/0.10/jmeter-plugins-manager-0.10.jar && \
    wget -P ${JMETER_DIR}/lib https://repo1.maven.org/maven2/kg/apc/cmdrunner/2.0/cmdrunner-2.0.jar && \
    java -cp ${JMETER_DIR}/lib/ext/jmeter-plugins-manager-0.10.jar org.jmeterplugins.repository.PluginManagerCMDInstaller

RUN ${JMETER_DIR}/bin/PluginsManagerCMD.sh install jpgc-casutg,jpgc-graphs-basic,jpgc-graphs-composite,jpgc-graphs-vs,jpgc-graphs-additional,jpgc-ggl,jpgc-cmd,jpgc-synthesis,jpgc-graphs-dist,jpgc-tst,jpgc-casutg,jpgc-functions

RUN ln -s ${JMETER_DIR}/bin/jmeter /usr/bin/jmeter
WORKDIR /jmeter
EXPOSE 4445
ENTRYPOINT ["jmeter"]
