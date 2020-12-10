FROM ruby:2.7.2-alpine

RUN apk update && \
    apk add bash

RUN mkdir -p /app
WORKDIR /app

COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app
