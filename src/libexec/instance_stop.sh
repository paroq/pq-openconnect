#!/usr/bin/env bash

daemon=openconnect
echo "stopping VPN..."

if test -z "$PQ_CHASSIS_VAR_DIR"
then
	printf "please specify the chassis var directory in the env variable PQ_CHASSIS_VAR_DIRECTORY"
	exit 1
fi

if test -z "$PQ_PART_DIR"
then
	printf "please specify the part directory in the env variable PQ_PART_DIR"
	exit 1
fi

pid=
chassis_var_dir=$PQ_CHASSIS_VAR_DIR
part_dir=$PQ_PART_DIR

if ! test -f ./$daemon.pid
then
	printf "VPN is not running.\n"
	exit 0
fi

pid=$( cat $daemon.pid )

if test -z "$pid"
then
	printf "VPN is not running.\n"
	rm -f ./$daemon.pid
	exit 0
fi

sudo true
sudo kill -TERM $pid 2>/dev/null

if test -f ./$daemon.pid
then
	rm -f ./$daemon.pid
fi
