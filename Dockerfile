# Using Ubuntu 20.04 Focal to access Gazebo Classic
FROM ubuntu:20.04

# Get git to be able to clone the repository,
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update                  \
        && apt-get install -y git

WORKDIR /opt

ENV PX4_TAG="v1.15.2"
RUN git clone -b ${PX4_TAG}                         \
        https://github.com/PX4/PX4-Autopilot.git    \
        --recurse-submodules                        \
        --depth=1

WORKDIR PX4-Autopilot

# Create this file because setup script depends on
# its existence to check if running in Docker
RUN touch /.dockerenv
RUN /usr/bin/bash Tools/setup/ubuntu.sh --no-nuttx

RUN apt-get update \
        && apt-get autoremove -y

# Build the project, use Gazebo Classic as it supports
# DONT_RUN flag to prebuild the simulator
RUN DONT_RUN=1 make px4_sitl gazebo-classic

# Install MavProxy
RUN apt-get update                      \
        && apt-get install -y python3   \
        && pip3 install MAVProxy

COPY entrypoint.sh .
RUN chmod +x ./entrypoint.sh

EXPOSE 5760/tcp

ENTRYPOINT ["./entrypoint.sh"]
CMD ["/usr/bin/bash"]
