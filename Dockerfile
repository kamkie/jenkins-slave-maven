FROM quay.io/openshift/origin-jenkins-agent-base:4.11.0

ENV MAVEN_VERSION=3.5 \
    BASH_ENV=/usr/local/bin/scl_enable \
    ENV=/usr/local/bin/scl_enable \
    PROMPT_COMMAND=". /usr/local/bin/scl_enable"

# Install Maven
RUN INSTALL_PKGS="java-11-openjdk-devel.x86_64 java-1.8.0-openjdk-devel.x86_64 maven*" && \
    curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
    curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    curl https://download.docker.com/linux/centos/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo && \
    curl https://download.docker.com/linux/centos/gpg -o /etc/pki/rpm-gpg/docker-gpg && \
    DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-fast-datapath --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl --disablerepo=docker-ce-stable" && \
    yum $DISABLES install --enablerepo=docker-ce-nightly -y $INSTALL_PKGS sudo device-mapper-persistent-data lvm2 docker-ce docker-ce-cli containerd.io && \
    rpm -V java-11-openjdk-devel.x86_64 java-1.8.0-openjdk-devel.x86_64 maven && \
    yum clean all -y && \
    mkdir -p $HOME/.m2

# When bash is started non-interactively, to run a shell script, for example it
# looks for this variable and source the content of this file. This will enable
# the SCL for all scripts without need to do 'scl enable'.
ADD contrib/bin/scl_enable /usr/local/bin/scl_enable
ADD contrib/bin/configure-agent /usr/local/bin/configure-agent
ADD ./contrib/settings.xml $HOME/.m2/

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME && \
    useradd -u 1001 jenkins && \
    usermod -aG wheel jenkins && \
    usermod -aG docker jenkins && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    rpm -V java-1.8.0-openjdk-devel.x86_64 maven docker-ce

USER 1001

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/entrypoint.sh"]
