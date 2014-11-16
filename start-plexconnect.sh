#!/bin/bash

if [ ! -f /plexconnect/trailers.cer ]; then
  echo "Generating SSL certificate"
  openssl req -new -nodes -newkey rsa:2048 \
    -out /plexconnect/trailers.pem -keyout /plexconnect/trailers.key \
    -x509 -days 7300 -subj "/C=US/CN=trailers.apple.com"
  openssl x509 -in /plexconnect/trailers.pem -outform der -out /plexconnect/trailers.cer \
    && cat /plexconnect/trailers.key >> /plexconnect/trailers.pem
fi

cd /opt/PlexConnect

cp /plexconnect/trailers.* assets/certificates/

echo [PlexConnect] > Settings.cfg
env | grep ^PLEXCONNECT_ | sed -E -e 's/^PLEXCONNECT_//' -e 's/(.*)=/\L\1 = /' >> Settings.cfg

echo
echo 'Using Settings.cfg:'
grep . Settings.cfg
echo

touch PlexConnect.log

git apply /opt/ip-self-external.patch

./PlexConnect.py &
tail -f PlexConnect.log
