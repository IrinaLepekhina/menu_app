FROM ruby:3.2-alpine

LABEL author="Irina"
  
RUN apk add --update \ 
  build-base \
  mariadb-dev \
  nodejs \
  git \
  && rm -rf /var/cashe/apk/*

RUN gem install bundler -v "2.4.2" -N

WORKDIR /app

COPY . /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

EXPOSE 3000

CMD rm -f tmp/pids/server.pid $ rails s, "0.0.0.0"