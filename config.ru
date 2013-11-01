require 'rubygems'
require './server'

map '/assets' do
  run HelloApp::Server.sprockets
end
 
map '/' do
  run HelloApp::Server
end
