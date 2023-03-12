FROM ruby:3.0.3

WORKDIR infra

COPY . /infra

RUN apt-get update -qq && apt-get install -y build-essential

RUN gem install bundler \
    && bundle config set frozen 'true' \
    && bundle install \

