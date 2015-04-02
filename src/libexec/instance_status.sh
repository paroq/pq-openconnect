#!/usr/bin/env bash

daemon=openconnect

if test -z "$PQ_CHASSIS_VAR_DIR"
then
	printf "please specify the chassis var directory in the env variable PQ_CHASSIS_VAR_DIRECTORY"
	exit 1
fi

if test -z "$PART_DIR"
then
	printf "please specify the part directory in the env variable PART_DIR"
	exit 1
fi

if ! test -f "./$daemon.pid"
then
	printf "VPN is not running.\n"
	exit 0
fi

pid=$( cat ./$daemon.pid )

if test -z "$pid"
then
	printf "VPN is not running.\n"
	exit 0
fi

sudo true

if sudo kill -0 $pid 2> /dev/null
then
	printf "VPN is running.\n"
	printf "pid=[$pid]\n"
else
	printf "VPN is not running.\n"
	rm -f ./$daemon.pid
fi
