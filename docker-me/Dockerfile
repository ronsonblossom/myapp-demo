FROM centos:latest
COPY app1 /var/www/html/
COPY app2 /var/www/cgi-bin/
RUN chmod -v +x /var/www/cgi-bin/app2
EXPOSE 80
ADD start.sh /start.sh
RUN chmod -v +x /start.sh
CMD ["/start.sh"]
