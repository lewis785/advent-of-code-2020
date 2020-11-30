FROM ruby:2.7.2-alpine

RUN apk update && \
    apk add bash && \
    mkdir -p /app
COPY . /app
WORKDIR /app
