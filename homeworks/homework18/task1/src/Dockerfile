FROM httpd:latest

RUN echo "<html><body><h1>Hello from Apache Docker Container!</h1></body></html>" > /usr/local/apache2/htdocs/index.html

EXPOSE 80

CMD ["httpd-foreground"]
