#!/bin/bash
set -e
if [ ! -f /root/router.ini ]; then
	if [ ! -z "$MASTER_DESTINATIONS" ]; then
		cat >> /root/router.ini <<-EOL
		[routing:master]
		bind_address = 0.0.0.0:$MASTER_PORT
		mode = read-write
		destinations = $MASTER_DESTINATIONS
		EOL
	fi

	if [ ! -z "$SLAVE_DESTINATIONS" ]; then
		cat >> /root/router.ini <<-EOL
		[routing:slave]
		bind_address = 0.0.0.0:$SLAVE_PORT
		mode = read-only
		destinations = $SLAVE_DESTINATIONS
		EOL
	fi
fi
exec "$@"
