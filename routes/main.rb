class HelloApp::Server < Sinatra::Application
  get '/' do
    erb :index
  end
end
