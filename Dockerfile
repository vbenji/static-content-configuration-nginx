FROM nginx:1.14-alpine-perl

# Copy simple http page for example
COPY html/index.html /usr/share/nginx/html/

# Add custom configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf