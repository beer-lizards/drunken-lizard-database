FROM gcr.io/drunken-lizards/flyway-docker:6b7ef5626447e44d4db99579544d86ebc756dffc

ENV DATABASE_IP=127.0.0.1 \
    DATABASE_NAME=drunken_lizard \
    DATABASE_PASSWORD=lizard \
    DATABASE_PORT=5432 \
    DATABASE_USERNAME=drunken

WORKDIR /root

ADD . /root

ENTRYPOINT ["/root/build/start.sh"]
