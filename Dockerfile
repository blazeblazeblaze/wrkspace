FROM ruby:2.5.1-slim

RUN apt-get update && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . /app

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
