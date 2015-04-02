#!/usr/bin/env bash

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

printf "Starting vpn...\n"

chassis_var_dir=$PQ_CHASSIS_VAR_DIR
part_dir=$PART_DIR
instance_name=$INSTANCE_NAME

if test -f "$PWD/../etc/config.vpn"
then
	source $PWD/../etc/config.vpn
else
	printf "ERROR: could not find ../etc/config.vpn\n"
	exit 1
fi

printf "Starting vpn with:\n"
printf "  url: $url\n"
printf "  username: $username\n"
printf "  password: $password\n"

sudo true

sudo $part_dir/sbin/openconnect $url --background --user $username --pid-file $PWD/openconnect.pid --pass $password --pid-file=$PWD/openconnect.pid &>>../log/openconnect.log
