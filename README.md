
# PX4 SitL in Docker

The aim is to be able to run ArduPilot SITL simulator on Docker so it is possible to develop UAV agent programs without hardware.

## Run image
Clone git repository https://github.com/iyicanme/px4-sitl-docker

```
git clone https://github.com/iyicanme/px4-sitl-docker.git
```

Build and the image

```
./run.sh
```

## Connecting to SITL

Creating a Mavlink connection to host port 55760 TCP port will cause the SITL to start sending constant UAV updates, such as position, battery level, memory information, mission, etc.

Easiest way to create a Mavlink connection is through MavProxy.

MavProxy is available through PyPI, it can be installed as follows.

Create a Python virtual environment

```
python3 -m virtualenv venv
```

This creates a virtual environment in the folder `venv`.

This assumes Python package `virtualenv` is installed.

Install `mavproxy` package

```
venv/bin/pip install mavproxy
```

Run `mavproxy` connection to the SITL instance listening on TCP port 55760

```
venv/bin/mavproxy.py --master=tcp:127.0.0.1:55760
```

Mavproxy can complain about ModemManager possibly interfering with MavProxy.
It can be beneficial to remove the package if an LTE connection is not being made use of. 
