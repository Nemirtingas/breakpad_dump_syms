FROM scottyhardy/docker-wine:latest
COPY dump_syms /dump_syms
ENV RUN_AS_ROOT=yes
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y curl && rm -rf /var/lib/apt/*
RUN ln -s /dump_syms/linux/dump_syms   /usr/bin/dump_syms_linux &&\
    ln -s /dump_syms/mac/dump_syms_mac /usr/bin/dump_syms_mac &&\
    ln -s /dump_syms/windows/run.sh    /usr/bin/dump_syms_windows
