FROM ruby:3.0.3

ENV PORT=3002

WORKDIR app

COPY --chown=pricing-app ["Gemfile", "Gemfile.lock", "/app/"]
COPY --from=messaging-infra /infra /infra

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN gem install bundler \
    && bundle config set frozen 'true' \
    && bundle install

RUN adduser pricing-app \
    && chown pricing-app /app
COPY --chown=pricing-app . /app

USER pricing-app

EXPOSE ${PORT}
CMD ./scripts/start-consumer
