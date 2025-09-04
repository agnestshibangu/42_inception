FROM debian:bookworm

EXPOSE 3306

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y \
    && apt install mariadb-server -y \
    && mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/init.sh /etc/mysql/init.sh

RUN chmod +x /etc/mysql/init.sh

VOLUME /var/lib/mysql

ENTRYPOINT ["/etc/mysql/init.sh"]
CMD ["mariadbd"]

