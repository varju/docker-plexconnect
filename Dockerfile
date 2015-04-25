FROM debian:jessie
MAINTAINER Alex Varju

RUN apt-get update \
  && apt-get install -y git python \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN cd /opt \
  && git clone https://github.com/iBaa/PlexConnect.git

# persistent storage for ssl certificates
VOLUME /plexconnect

COPY start-plexconnect.sh ip-self-external.patch /opt/

CMD /opt/start-plexconnect.sh
