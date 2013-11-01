require 'rake/sprocketstask'
require './server'

namespace :assets do
  Rake::SprocketsTask.new(:precompile) do |t|
    t.environment = HelloApp::Server.sprockets
    t.output = "#{File.dirname(__FILE__)}/public/assets"

    # js / css
    t.assets = %w{ application.js application.css }

    # images
    t.assets << lambda do |path, filename|
      filename =~ /\/assets/ && !%w(.js .css).include?(File.extname(path))
    end
  end
end
