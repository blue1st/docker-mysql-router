FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -y curl apparmor && rm -rf /var/lib/apt/lists/*

ARG MYSQL_ROUTER_VERSION=8.0.3
RUN curl -fSL -o mysql-router.deb http://dev.mysql.com/get/Downloads/MySQL-Router/mysql-router_${MYSQL_ROUTER_VERSION}-dmr-1debian9_amd64.deb
RUN dpkg -i mysql-router.deb && rm -f mysql-router.deb

ENV MASTER_PORT=3306 SLAVE_PORT=3306

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

CMD ["/usr/bin/mysqlrouter", "--extra-config=/root/router.ini"]

