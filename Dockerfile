FROM ruby:3.3-alpine

LABEL Name=not_monads Version=0.1.0

RUN apk add --update git openssh-client

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock not_monads.gemspec ./
COPY lib/not_monads/version.rb lib/not_monads/version.rb
RUN bundle install

COPY . /app

# CMD ["ruby", "serviceobjects.rb"]
