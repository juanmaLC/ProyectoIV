FROM ruby:latest

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1


COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["bundle", "rackup", "config.ru"]

