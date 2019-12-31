FROM alpine:latest
MAINTAINER Kyle Farwell m@kfarwell.org
EXPOSE 42069
COPY . /kwerc
RUN apk update && \
    apk add nginx fcgiwrap spawn-fcgi mawk && \
    apk add 9base --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ && \
    rm -rf /var/cache/apk/* \
           /etc/nginx/conf.d/default.conf && \
    mv /kwerc/nginx.conf /etc/nginx/conf.d/kwerc.conf && \
    mkdir -p /run/nginx && \
    chown -R nginx:nginx /kwerc
CMD spawn-fcgi -u nginx -s /run/fcgi.sock /usr/bin/fcgiwrap && \
    nginx -g "daemon off;"
