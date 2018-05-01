FROM ruby:2.3.0

COPY Gemfile Gemfile.lock /code/

WORKDIR /code

RUN gem install bundler
RUN bundle install
