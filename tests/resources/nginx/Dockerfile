FROM openresty/openresty:alpine

RUN apk add --no-cache luarocks5.3

COPY ./tests/resources/nginx/nginx.conf /etc/nginx/conf.d/cone.conf

COPY ./src /cone
RUN cd /cone && luarocks-5.3 make ./cone-*.rockspec && luarocks-5.3 install --only-deps ./cone-*.rockspec
