FROM httpd:2.4

COPY ./docker/apache/httpd.conf /usr/local/apache2/conf/httpd.conf

COPY ./docker/apache/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9000

CMD ["httpd-foreground"]