FROM ruby:2.7.3-alpine AS development

RUN apk add --no-cache --update \
      build-base \
      bash \
      tzdata \
      postgresql-dev \
      postgresql-client \
      libxslt-dev \
      libxml2-dev \
      imagemagick \
      git \
      less \
      nodejs

WORKDIR /usr/local/src/app

RUN gem update --system

COPY . /usr/local/src/app

RUN bundle install --jobs 4 --retry 3

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
