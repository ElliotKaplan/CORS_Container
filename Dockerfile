FROM alpine
RUN apk add --no-cache lighttpd && \
    rm -rf /var/cache/apk/*

COPY CORS_POC /var/www/
COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY response_headers.conf /etc/lighttpd/response_headers.conf

EXPOSE 80
ENTRYPOINT ["lighttpd", "-f", "/etc/lighttpd/lighttpd.conf", "-D"]
