#!/bin/sh

set -e

STARTDIR=`pwd`

/tmp/beat/bin/beat-0.1.0 stop || echo "No previous node running."
rm -rf /tmp/beat

git checkout v1
rebar3 tar

git checkout v2
rebar3 release relup
rebar3 tar

mkdir -p /tmp/beat
cp _build/default/rel/beat/beat-0.1.0.tar.gz /tmp
cp _build/default/rel/beat/beat-0.1.1.tar.gz /tmp/beat-0.1.1.tar.gz

cd /tmp/beat
tar -zxf /tmp/beat-0.1.0.tar.gz

echo "STARTING NODE"
./bin/beat-0.1.0 start

mkdir -p releases/0.1.1
cp /tmp/beat-0.1.1.tar.gz releases/0.1.1/beat.tar.gz

sleep 5s # let the system boot

echo "UPGRADING NODE TO 0.1.1"
./bin/beat-0.1.0 upgrade "0.1.1/beat"

rm /tmp/beat-0.1.0.tar.gz
rm /tmp/beat-0.1.1.tar.gz

cd $STARTDIR
git checkout master
