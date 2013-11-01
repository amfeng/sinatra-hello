module HelloApp::Authentication
  use Rack::Session::Cookie, :secret => 'SECRET'


  use Warden::Manager do |manager|
    manager.default_strategies :password
    manager.failure_app = HelloApp::Server
    manager.serialize_into_session {|user| user.id}
    manager.serialize_from_session {|id| User.find(id)}
  end

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:password) do
    def valid?
      params['email'] && params['password']
    end

    def authenticate!
      user = User.find_by(:email => params['email'])
      if user && user.authenticate(params['password'])
        success!(user)
      else
        fail!('Could not log in')
      end
    end
  end

  get '/login' do
    erb :login
  end

  get '/logout' do
    warden.logout
    redirect '/'
  end

  post '/sessions' do
    warden.authenticate!
    if warden.authenticated?
      redirect '/'
    end
  end

  post '/unauthenticated' do
    redirect '/'
  end

  def warden
    env['warden']
  end

  def login_required
    if warden.user
      @current_user = warden.user
    else
      halt 403, {:ok => false, :error => 'You must be logged in.'}.to_json
    end
  end

  before do
    @current_user = warden.user
  end
end
