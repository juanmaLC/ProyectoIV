FROM ruby:latest

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1


COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

#RUN useradd -m juanma
#USER juanma
CMD ["bundle", "exec", "rackup"]

