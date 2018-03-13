FROM ruby:2.5.0
MAINTAINER Zulkar <zulkar@bedelbaev.com>

ENV APP_DIR=/usr/src/app

RUN apt-get update \
  && apt-get install -y nodejs --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
  && apt-get install -y postgresql-client \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

COPY Gemfile $APP_DIR/
COPY Gemfile.lock $APP_DIR/

RUN bundle install --system

COPY . $APP_DIR

EXPOSE 3000

CMD rm -rf tmp/pids/server.pid \
    && rails server -b 0.0.0.0 -p 3000
