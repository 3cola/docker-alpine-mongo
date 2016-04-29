From alpine:edge

ADD run /

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  apk update && \
  apk add --no-cache mongodb mongodb-tools

VOLUME /data/db
EXPOSE 27017 28017

ENTRYPOINT [ "/run" ]
CMD [ "mongod" ]
