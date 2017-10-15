FROM ruby:2.4.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

ENV APP_PATH=/funbox_test
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

COPY Gemfile* ./
RUN bundle install

COPY . $APP_PATH

COPY ./config/database.yml.example ./config/database.yml
COPY ./config/secrets.yml.example ./config/secrets.yml
COPY .env.example .env

#RUN whenever --update-crontab