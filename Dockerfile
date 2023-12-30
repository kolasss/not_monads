FROM ruby:3.3-alpine

LABEL Name=not_monads Version=0.1.0


# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

WORKDIR /app
COPY . /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

# CMD ["ruby", "serviceobjects.rb"]
