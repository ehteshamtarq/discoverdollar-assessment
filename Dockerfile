FROM ubuntu:latest
RUN  apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apache2 \
    mysql-server \
    php7.0 \
    php8.1-bcmath\
    wget

COPY start-script.sh /root/
RUN chmod +x /root/start-script.sh && /root/start-script.sh
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN cd /var/www/html/










