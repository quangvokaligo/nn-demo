FROM ruby:alpine

RUN apk add --no-cache --update build-base linux-headers tzdata postgresql-dev

WORKDIR /nn-demo

COPY Gemfile Gemfile.lock /nn-demo/
RUN gem install --no-document bundler && bundle

COPY . /nn-demo
