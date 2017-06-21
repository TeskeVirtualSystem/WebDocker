# WebDocker
Simple Ubuntu 16.04 + Apache2 + PHP5.6 with external config on Docker.


# Run

```bash
docker container run -v /path/to/apacheconf:/etc/apache2 -v /path/to/www:/var/www/ -v /path/to/apacheconf/php:/etc/php -p 80:80 -p 443:443 -d webdocker:latest
```
