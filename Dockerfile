FROM nginx:alpine

COPY index.html /urs/share/nginx/html/index.html

EXPOSE 80

