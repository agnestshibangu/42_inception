FROM debian:bookworm

# Empêche les invites interactives
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y \
    && apt install -y nginx openssl \
    && mkdir -p /etc/nginx/ssl/ /run/nginx

# Configuration Nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Certificats SSL
COPY tools/nginx.key /etc/nginx/ssl/nginx.key
COPY tools/nginx.crt /etc/nginx/ssl/nginx.crt

# Expose le port HTTPS
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

