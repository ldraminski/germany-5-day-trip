FROM nginx:alpine

# Usuń domyślną konfigurację
RUN rm -rf /usr/share/nginx/html/*

# Kopiuj pliki projektu
COPY index.html /usr/share/nginx/html/
COPY *.png /usr/share/nginx/html/

# Prosta konfiguracja nginx dla wydajności
RUN echo 'server { \
    listen 80; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ =404; \
    } \
    location ~* \.(png|jpg|jpeg|gif|ico|css|js)$ { \
        expires 7d; \
        add_header Cache-Control "public, immutable"; \
    } \
    gzip on; \
    gzip_types text/html text/css application/javascript; \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
