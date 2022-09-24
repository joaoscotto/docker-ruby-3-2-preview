FROM ruby:3.2-rc-alpine3.16 AS builder

RUN apk add \
  build-base \
  postgresql-dev

COPY Gemfile* .

RUN bundle install

FROM ruby:3.2-rc-alpine3.16 AS runner

RUN apk add \
    tzdata \
    nodejs \
    postgresql-dev

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

WORKDIR /usr/src/app

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

COPY . .

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]