docker build -t px4-sitl . \
        && docker run -t -p 55760:5760 px4-sitl