FROM buildpack-deps

RUN hg clone https://hg.mozilla.org/projects/nspr
RUN hg clone https://hg.mozilla.org/projects/nss

ENV USE_64=1 NSS_ENABLE_TLS_1_3=1

RUN cd nss && make nss_build_all && make install

RUN mv /dist/$(uname -s)$(uname -r | cut -f 1-2 -d . -)_$(uname -m)_${CC:-cc}_glibc_PTH_64_$([ -n "$BUILD_OPT" ] && echo OPT || echo DBG).OBJ /dist/OBJ-PATH

ENV LD_LIBRARY_PATH=/dist/OBJ-PATH/lib
ENV PATH /dist/OBJ-PATH/bin:$PATH

RUN mkdir /certdb && \
        /dist/OBJ-PATH/bin/certutil -d /certdb -N --empty-password && \
        /dist/OBJ-PATH/bin/certutil -d /certdb -S -n rsa-server -t u -x -s CN=localhost -k rsa -z /dev/null
