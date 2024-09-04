FROM httpd:2.4.62

MAINTAINER NSHenry <NSHenry@users.noreply.github.com>

COPY proxy-module.conf ./
RUN cat proxy-module.conf >> conf/httpd.conf

CMD ["httpd-foreground"]

