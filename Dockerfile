FROM ruby:latest

COPY Gemfile Gemfile.lock /code/

WORKDIR /code

RUN gem install bundler
RUN bundle install

ENV DB_USER=postgres
ENV DB_PASSWORD=
ENV DB_HOST=db
