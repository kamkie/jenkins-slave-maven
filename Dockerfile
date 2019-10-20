FROM centos:centos8
#RUN dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo && \
#    dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
#RUN dnf install -y sudo java-11-openjdk-devel.x86_64

#RUN dnf install -y python3
#RUN curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
#    curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
#RUN dnf install -y centos-release-scl && dnf config-manager --disable centos-sclo-rh
#RUN dnf repolist

#RUN dnf install -y \
#    http://mirror.centos.org/centos/7/os/x86_64/Packages/policycoreutils-python-2.5-33.el7.x86_64.rpm \
#    http://mirror.centos.org/centos/7/extras/x86_64/Packages/container-selinux-2.107-3.el7.noarch.rpm
#    http://mirror.centos.org/centos/7/os/x86_64/Packages/libtool-ltdl-2.4.2-22.el7_3.x86_64.rpm \
#    http://mirror.centos.org/centos/7/extras/x86_64/Packages/pigz-2.3.3-1.el7.centos.x86_64.rpm
#RUN dnf install -y docker-ce
#RUN cat /etc/dnf/dnf.conf
#RUN cat /etc/yum.conf
#RUN dnf install -y python:x86_64:27.5-86.el7 --allowerasing
#RUN dnf install -y python-2.7.5-86.el7.x86_64
#RUN dnf install -y @python27 && alternatives --set python /usr/bin/python3
#RUN dnf install -y http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/policycoreutils-python-utils-2.8-16.1.el8.noarch.rpm
#RUN ls -l /usr/bin/python*
#RUN dnf install -y policycoreutils-python --nobest --allowerasing
#RUN dnf install -y container-selinux --nobest --allowerasing
#RUN dnf install -y docker-ce --nobest --allowerasing

#RUN podman info
RUN dnf install -y podman

#RUN chown -R 1001:0 $HOME && \
#    chmod -R g+rw $HOME && \
#    useradd -u 1001 jenkins && \
#    usermod -aG wheel jenkins && \
#    usermod -aG docker jenkins && \
#    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
#    rpm -V java-11-openjdk-devel.x86_64 docker-ce
#
#USER 1001
#
#ADD entrypoint.sh /entrypoint.sh
#
#ENTRYPOINT ["/usr/bin/dumb-init", "--", "/entrypoint.sh"]
