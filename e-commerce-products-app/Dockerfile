FROM ruby:3.0.3

ENV PORT=3001

WORKDIR app

COPY --chown=products-app ["Gemfile", "Gemfile.lock", "/app/"]
COPY --from=messaging-infra /infra /infra

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN gem install bundler \
    && bundle config set frozen 'true' \
    && bundle install

RUN adduser products-app \
    && chown products-app /app
COPY --chown=products-app . /app

USER products-app

EXPOSE ${PORT}
CMD bundle exec rails s -p $PORT -b 0.0.0.0
