ARG DOCKER_WINE_VER
FROM scottyhardy/docker-wine:${DOCKER_WINE_VER}

ENV RUN_AS_ROOT=yes
ENV XVFB_SERVER=:90
ENV XVFB_SCREEN=0
ENV XVFB_RESOLUTION=800x600x8
ENV DISPLAY=:90

COPY dump_syms /dump_syms
RUN apt-get update &&\
    DEBIAN_FRONTEND="noninteractive"\
    apt-get install -y curl &&\
    rm -rf /var/lib/apt/*
RUN nohup /usr/bin/Xvfb "${XVFB_SERVER}" -screen "${XVFB_SCREEN}" "${XVFB_RESOLUTION}" >/dev/null 2>&1 &\
    winecfg /v win10 &&\
    mkdir /root/.wine/drive_c/extra_dlls &&\
    wineserver -k
RUN cp /dump_syms/windows/msdia140.dll /root/.wine/drive_c/extra_dlls/ &&\
    regsvr32 /s /root/.wine/drive_c/extra_dlls/msdia140.dll &&\
    wineserver -k
RUN ln -s /dump_syms/linux/dump_syms   /usr/bin/dump_syms_linux &&\
    ln -s /dump_syms/mac/dump_syms_mac /usr/bin/dump_syms_mac &&\
    ln -s /dump_syms/windows/run.sh    /usr/bin/dump_syms_windows

ENTRYPOINT ["/usr/bin/entrypoint"]
