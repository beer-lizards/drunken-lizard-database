FROM flyway-docker

ENV DATABASE_IP=127.0.0.1 \
    DATABASE_NAME=drunken_lizard \
    DATABASE_PASSWORD=lizard \
    DATABASE_PORT=5432 \
    DATABASE_USERNAME=drunken

WORKDIR /root

ADD . /root

ENTRYPOINT ["/root/build/start.sh"]
