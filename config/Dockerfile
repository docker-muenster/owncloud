FROM alpine:3.3

# RUN apk --update-cache add netcat-openbsd

RUN mkdir -p /opt/owncloud-config-mixin/
COPY ./first-run.sh /opt/owncloud-config-mixin/
VOLUME /opt/owncloud-config-mixin

CMD ["/bin/true"]
