FROM ruby:2.3.0-alpine

RUN apk add tor --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/community/ --allow-untrusted haproxy

RUN apk --update add --virtual build-dependencies build-base libxml2-dev libxslt-dev \
  && gem install --no-ri --no-rdoc nokogiri socksify \
  && apk del build-dependencies \
  && rm -rf /var/cache/apk/*

ADD haproxy.cfg.erb /usr/local/etc/haproxy.cfg.erb

ADD start.rb /usr/local/bin/start.rb
RUN chmod +x /usr/local/bin/start.rb

EXPOSE 5566

CMD ruby /usr/local/bin/start.rb
