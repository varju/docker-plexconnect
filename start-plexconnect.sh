#!/bin/sh
set -e

cd /opt/PlexConnect

COMMIT_URL=https://github.com/iBaa/PlexConnect/commit/$(git rev-parse HEAD)
echo
echo "PlexConnect build ${COMMIT_URL}"
echo

if [ ! -f /plexconnect/trailers.cer ]; then
  echo "Generating SSL certificate"
  openssl req -new -nodes -newkey rsa:2048 \
    -out /plexconnect/trailers.pem -keyout /plexconnect/trailers.key \
    -x509 -days 7300 -subj "/C=US/CN=trailers.apple.com"
  openssl x509 -in /plexconnect/trailers.pem -outform der -out /plexconnect/trailers.cer \
    && cat /plexconnect/trailers.key >> /plexconnect/trailers.pem
fi

if [ ! -f ATVSettings.cfg ]; then
  ln -s /plexconnect/ATVSettings.cfg
fi

cp /plexconnect/trailers.* assets/certificates/

# Migrate from legacy setting
if [ -n "$PLEXCONNECT_IP_PLEXCONNECT_EXTERNAL" ]; then
  echo "PLEXCONNECT_IP_PLEXCONNECT_EXTERNAL is deprecated, use PLEXCONNECT_USE_CUSTOM_DNS_BIND_IP and PLEXCONNECT_CUSTOM_DNS_BIND_IP"
  export PLEXCONNECT_USE_CUSTOM_DNS_BIND_IP=True
  export PLEXCONNECT_CUSTOM_DNS_BIND_IP=$PLEXCONNECT_IP_PLEXCONNECT_EXTERNAL
  unset PLEXCONNECT_IP_PLEXCONNECT_EXTERNAL
fi

echo [PlexConnect] > Settings.cfg
env | grep ^PLEXCONNECT_ | sed -E -e 's/^PLEXCONNECT_//' -e 's/(.*)=/\L\1 = /' >> Settings.cfg

echo
echo 'Using Settings.cfg:'
grep . Settings.cfg
echo

touch PlexConnect.log

./PlexConnect.py &
tail -f PlexConnect.log
