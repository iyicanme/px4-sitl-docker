#! /usr/bin/bash

set +e

python3 /usr/local/bin/mavproxy.py --daemon --master=udp:127.0.0.1:14550 --out=tcpin:0.0.0.0:5760 --udp-timeout=1 --nowait &

HEADLESS=1 make px4_sitl gazebo-classic
