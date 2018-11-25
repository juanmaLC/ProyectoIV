FROM ruby:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1


COPY Gemfile Gemfile.lock ./
COPY . .
RUN bundle install


CMD ["ruby","app/inicio.rb"]
