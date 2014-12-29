FROM debian:jessie
MAINTAINER Alex Varju

RUN apt-get update && apt-get install -y git python && apt-get clean

ENV VERSION ee2dab7

RUN cd /opt \
  && git clone https://github.com/iBaa/PlexConnect.git \
  && cd PlexConnect \
  && git reset --hard $VERSION

# persistent storage for ssl certificates
VOLUME /plexconnect

COPY start-plexconnect.sh ip-self-external.patch /opt/

CMD /opt/start-plexconnect.sh
