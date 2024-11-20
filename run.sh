docker build -t px4-sitl .
docker run -t -p 5760:5760 px4-sitl