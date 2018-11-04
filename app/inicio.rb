require 'rubygems'
require 'sinatra/base'
require 'sinatra'


class Inicio < Sinatra::Base

get '/' do
  "Hello World"
end

end
