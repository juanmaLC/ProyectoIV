FROM ruby:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1


COPY Gemfile Gemfile.lock ./
COPY . .
RUN bundle install




CMD ["bundle","exec","rackup","-p", "80" ,"--host", "0.0.0.0"]


