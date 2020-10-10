FROM ruby:2.4-alpine

RUN mkdir /root/random
WORKDIR /root/random

COPY ./Gemfile /root/random
COPY ./app.rb /root/random
COPY ./views /root/random/views

RUN bundle install
EXPOSE 4567

CMD bundle exec ruby app.rb -o 0.0.0.0
