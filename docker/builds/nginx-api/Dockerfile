FROM nginx:alpine

RUN addgroup -g 3000 -S app
RUN adduser -u 3000 -S -D -G app app

RUN apk add --no-cache bash

COPY site.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /app
