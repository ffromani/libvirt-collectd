FROM kubevirt/libvirt:4.2.0

MAINTAINER "Francesco Romani" <fromani@redhat.com>
ENV container docker

RUN \
  dnf install -y \
    collectd collectd-virt collectd-write_prometheus && \
  dnf clean all

COPY config/collectd.conf /etc/collectd.conf
COPY config/collectd.d/*.conf /etc/collectd.d/

COPY _output/bin/* /usr/bin/
RUN mkdir -p /etc/libvirt/hooks
COPY hook.sh /etc/libvirt/hooks/daemon

EXPOSE 9090

CMD ["/libvirtd.sh"]
