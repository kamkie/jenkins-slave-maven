FROM quay.io/openshift/origin-jenkins-agent-base:v4.0

MAINTAINER Gabe Montero <gmontero@redhat.com>

ENV MAVEN_VERSION=3.6 \
    GRADLE_VERSION=4.2.1 \
    BASH_ENV=/usr/local/bin/scl_enable \
    ENV=/usr/local/bin/scl_enable \
    PROMPT_COMMAND=". /usr/local/bin/scl_enable" \
    PATH=$PATH:/opt/gradle/bin \
    OPENSHIFT_JENKINS_JVM_ARCH=x86_64

# Install Maven
RUN set -e \
    INSTALL_PKGS="java-1.8.0-openjdk-devel.x86_64 maven*" && \
    curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
    curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum-config-manager --disable rhel-server-extras rhel-server rhel-fast-datapath rhel-server-optional rhel-server-ose rhel-server-rhscl && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install -y $INSTALL_PKGS  device-mapper-persistent-data lvm2 docker-ce docker-ce-cli containerd.io && \
    curl -LOk https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip -d /opt && \
    rm -f gradle-${GRADLE_VERSION}-bin.zip && \
    ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle && \
    rpm -V java-1.8.0-openjdk-devel.x86_64 maven docker-ce && \
    yum clean all -y && \
    mkdir -p $HOME/.m2 && \
    mkdir -p $HOME/.gradle

# When bash is started non-interactively, to run a shell script, for example it
# looks for this variable and source the content of this file. This will enable
# the SCL for all scripts without need to do 'scl enable'.
ADD contrib/bin/scl_enable /usr/local/bin/scl_enable
ADD contrib/bin/configure-agent /usr/local/bin/configure-agent
ADD ./contrib/settings.xml $HOME/.m2/
ADD ./contrib/init.gradle $HOME/.gradle/

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001
