Runs [PlexConnect](https://github.com/iBaa/PlexConnect) in a Docker container.

Sample execution
----------------

```
docker run -d \
  -p 53:53/udp -p 80:80 -p 443:443 \
  -v /data/plexconnect:/plexconnect \
  -e PLEXCONNECT_ENABLE_PLEXGDM=False \
  -e PLEXCONNECT_IP_PMS=192.168.1.2 \
  -e PLEXCONNECT_IP_PLEXCONNECT_EXTERNAL=192.168.1.11 \
  varju/plexconnect
```

Environment tunables
--------------------

- `PLEXCONNECT_ENABLE_PLEXGDM` (default: True)
- `PLEXCONNECT_IP_PMS` (default: 192.168.178.10)
- `PLEXCONNECT_PORT_PMS` (default: 32400)
- `PLEXCONNECT_IP_DNSMASTER` (default: 8.8.8.8)
- `PLEXCONNECT_PREVENT_ATV_UPDATE` (default: True)
- `PLEXCONNECT_HOSTTOINTERCEPT` (default: trailers.apple.com)
- `PLEXCONNECT_LOGLEVEL` (default: Normal)

See [Settings for advanced use and troubleshooting](https://github.com/iBaa/PlexConnect/wiki/Settings-for-advanced-use-and-troubleshooting) for more details.
