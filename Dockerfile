FROM alpine:latest
MAINTAINER Kyle Farwell m@kfarwell.org
EXPOSE 42069
COPY . /kwerc
RUN adduser -DHs /sbin/nologin kwerc && \
    chown -R root:kwerc /kwerc && \
    find /kwerc -type d -exec chmod 750 {} \; && \
    find /kwerc -type f -exec chmod 640 {} \; && \
    chmod 750 /kwerc/bin/cgd /kwerc/bin/kwerc.rc /kwerc/bin/redli
USER kwerc
CMD /kwerc/bin/cgd -a :42069 -c /kwerc/bin/kwerc.rc
