FROM registry.centos.org/che-stacks/centos-jdk8

LABEL che:server:8080:ref=quarkus-dev che:server:8080:protocol=http che:server:5005:ref=quarkus-debug che:server:5005:protocol=http che:server:9876:ref=codeserver che:server:9876:protocol=http

ARG OC_VERSION=3.11.43
ARG QUARKUS_VERSION=0.12.0

COPY ["./general-deps.install", "/tmp/install/"]
RUN sudo chown user:user /tmp/install /tmp/install/* && \
    /tmp/install/general-deps.install ${OC_VERSION} && \
    sudo rm -rf /tmp/install


# The following lines are needed to set the correct locale after `yum update`
# c.f. https://github.com/CentOS/sig-cloud-instance-images/issues/71
RUN sudo localedef -i en_US -f UTF-8 C.UTF-8
ENV LANG="C.UTF-8"

# Generate group.template
RUN cat /etc/group | \
    sed s#root:x:0:#root:x:0:0,\${USER_ID}:#g \
    > /home/user/group.template

ENV HOME /home/user
ENV M2_HOME=/opt/apache-maven-3.6.0

COPY ["./download-maven-deps.sh", "/tmp/maven-deps/"]
RUN sudo chown user:user /tmp/maven-deps /tmp/maven-deps/* && \
    /tmp/maven-deps/download-maven-deps.sh ${QUARKUS_VERSION} && \
    sudo rm -rf /tmp/maven-deps

COPY ["./entrypoint.sh", "/home/user/entrypoint.sh"]
ENTRYPOINT ["/home/user/entrypoint.sh"]
CMD tail -f /dev/null

# Give write access to /home/user for users with an arbitrary UID
COPY ["./grant-access-arbitrary-UID.sh", "/tmp/install/"]
RUN sudo chown user:user /tmp/install /tmp/install/* && \
    /tmp/install/grant-access-arbitrary-UID.sh && \
    sudo rm -rf /tmp/install
