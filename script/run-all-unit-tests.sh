#!/bin/bash

# Uncomment this if you want to enable debug
#set -x

set -e

if [[ ! -d ./apps ]] ; then
	./bootstrap
fi

source script/dev/configure
source script/checkout
 
apps_and_ports=`cat script/apps | grep -v \# | grep -v '^\s*$'`

for app_and_port in ${apps_and_ports}; do
	app=`echo ${app_and_port} | cut -d':' -f1`

	echo "Running unit tests for ${app}"

	cd apps/${app}
	dev/run-unit-tests
	cd ../..
done