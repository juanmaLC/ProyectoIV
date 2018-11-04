require 'rubygems' 
require 'sinatra' 
require 'bundler'
Bundler.require
require './app/inicio' 
run Sinatra::Application 
