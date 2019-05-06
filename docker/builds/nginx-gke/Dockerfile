FROM skyerus/environments:nginx-api

ENV PHP_FPM_HOST='localhost'

CMD ["/bin/bash", "-c", "envsubst '$$PHP_FPM_HOST' < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"]
