require 'sinatra'
require 'mongoid'
require 'warden'
require 'sprockets'
require 'sass'
require 'uglifier'

module HelloApp; end;

require './lib/db'
require './lib/authentication'

class HelloApp::Server < Sinatra::Application
  include HelloApp::Authentication

  set :root, File.expand_path('../', __FILE__)
  set :sprockets, Sprockets::Environment.new(root)

  configure do
    sprockets.append_path 'assets/javascripts'
    sprockets.append_path 'assets/stylesheets'
    sprockets.append_path 'assets/images'
  end

  configure :production do
    sprockets.js_compressor = :uglifier
    sprockets.css_compressor = :scss
  end
end

require './routes/main'
