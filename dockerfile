FROM python:3.12-slim

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y unzip
RUN apt-get install -y curl
RUN curl -L https://templatemo.com/download/templatemo_600_prism_flux -o /tmp/template.zip
RUN rm /etc/nginx/sites-enabled/default
RUN unzip /tmp/template.zip -d /tmp/

RUN cp -r /tmp/templatemo_600_prism_flux/* /var/www/html/

RUN printf 'server {\n\
    listen 80;\n\
    server_name localhost;\n\
    root /var/www/html;\n\
    index index.html;\n\
    location / {\n\
        try_files $uri $uri/ =404;\n\
    }\n\
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
