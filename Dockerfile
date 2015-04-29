FROM debian:jessie
MAINTAINER Alex Varju

RUN apt-get update \
  && apt-get install -y git python \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY start-plexconnect.sh ip-self-external.patch /opt/

RUN cd /opt \
  && git clone https://github.com/iBaa/PlexConnect.git \
  && cd PlexConnect \
  && git apply /opt/ip-self-external.patch

# persistent storage for ssl certificates
VOLUME /plexconnect

CMD /opt/start-plexconnect.sh
