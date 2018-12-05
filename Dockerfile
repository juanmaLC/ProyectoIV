FROM ruby:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1


COPY Gemfile .
COPY Gemfile.lock .

COPY app/ .
COPY app/inicio.rb app/inicio.rb

COPY datos/ .
COPY datos/clasesOfrecidas.json datos/clasesOfrecidas.json  

COPY lib/ .
COPY lib/ClasesGym.rb lib/ClasesGym.rb
COPY config.ru .

RUN bundle install




CMD ["bundle","exec","rackup","-p", "80" ,"--host", "0.0.0.0"]


