FROM ruby:2.5.1

COPY Gemfile Gemfile.lock /code/

WORKDIR /code

RUN gem install bundler
RUN bundle install
