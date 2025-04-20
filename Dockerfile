FROM ruby:3.2.2

ENV APP_PATH=/usr/src/app

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    libsodium-dev \
    nano \
    postgresql-client \
    postgresql-client-common

RUN apt-get -q clean

RUN mkdir -p $APP_PATH

WORKDIR $APP_PATH

COPY Gemfile* $APP_PATH/

RUN gem install bundler -v 2.6.3
RUN bundle install

COPY . $APP_PATH

EXPOSE 3000