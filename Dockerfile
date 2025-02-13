# FROM nginx:1.27.3
# ADD index.html /usr/share/nginx/html
# ADD style.css /usr/share/nginx/html

FROM caddy:latest
COPY index.html /usr/share/caddy/index.html
COPY style.css /usr/share/caddy/style.css