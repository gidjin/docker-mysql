FROM phusion/passenger-customizable:0.9.14
MAINTAINER John Gedeon <js1@gedeons.com>

# Set correct environment variables.
ENV HOME /root

# install basics
RUN /build/utilities.sh

CMD ["/sbin/my_init"]

# Install Mysql
RUN apt-get update && apt-get -yq install mysql-server-5.6 pwgen

# port
EXPOSE 3306

# Add MySQL configuration
COPY my.cnf /etc/mysql/conf.d/my.cnf
COPY mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf

# Add basics
COPY bootstrap.sh /etc/my_init.d/bootstrap.sh
RUN chmod 755 /etc/my_init.d/bootstrap.sh

# Clean up apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN chown -R mysql:mysql /var/lib/mysql

# Add VOLUMEs to allow backup of config and databases
VOLUME  ["/etc/mysql", "/var/lib/mysql"]
