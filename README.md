# CORS_Container
Docker container for hosting CORS attacks against vulnerable sites

## Serving the Exploit

This exploit is served using a Docker container from this directory run

    $ docker build -t cors_poc .

to build the container. Then run

    $ docker run --rm --hostname cors-poc -p 8000:80 -v /path/to/poc.js:/var/www/poc.js cors_poc

for the exploit server to be available on localhost on port 8000. This
will serve the malicious javascript and the appropriate
Access-Control headers to exploit a logged in user.

## Custom Response Headers

This container separates the response header definition for `lighttpd` off into a separate file `/etc/lighttpd/response_headers.conf`. If you need to set different response headers than 

    Access-Control-Allow-Origin: *
    Access-Control-Allow-Credentials: true
    
you should mount a new `.conf` file to with the following flag

    -v /path/to/response_headers.conf:/etc/lighttpd/response_headers.conf


## Firing the Exploit

Log into the vulnerable service with a target account. From the same
browser visit http://localhost:8000/poc.html. Be sure that the
developer tools are open before visiting the site to record the
subsequent requests that the browser then makes.

