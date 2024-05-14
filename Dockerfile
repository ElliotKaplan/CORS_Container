FROM alpine
RUN apk add --no-cache lighttpd openssl && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /etc/lighttpd/ssl/domain.com

COPY CORS_POC /var/www/
COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY response_headers.conf /etc/lighttpd/response_headers.conf
COPY server.pem /etc/lighttpd/ssl/domain.com/

RUN chmod 0600 /etc/lighttpd/ssl/domain.com/*
RUN chown -R lighttpd:lighttpd /etc/lighttpd/ssl/domain.com
RUN ln -s /var/www/poc.html /var/www/index.html

EXPOSE 80
EXPOSE 443
ENTRYPOINT ["lighttpd", "-f", "/etc/lighttpd/lighttpd.conf", "-D"]
