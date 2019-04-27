#!/bin/bash
CMD=$@

# Check if Root. If not, quit.
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


if [[ $1 = 'stop' ]]
then
  echo "Stopping. May take up to 30 seconds"
  docker stop `docker ps -q --filter="name=kalite-arm"`
elif [[ $1 = 'build' ]]
then
  docker build -t arm-kalite-img src
else
  docker run \
  -it \
  --rm \
  --name "kalite-arm" \
  -v $(pwd)/qemu-arm-static:/usr/bin/qemu-arm-static \
  arm-kalite-img
fi
