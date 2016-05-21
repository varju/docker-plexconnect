FROM alpine:latest
MAINTAINER Alex Varju

RUN apk add --update \
    git \
    python \
  && rm -rf /var/cache/apk/*

COPY start-plexconnect.sh ip-self-external.patch /opt/

RUN cd /opt \
  && git clone https://github.com/iBaa/PlexConnect.git \
  && cd PlexConnect \
  && git apply /opt/ip-self-external.patch

# persistent storage for ssl certificates
VOLUME /plexconnect

CMD /opt/start-plexconnect.sh
