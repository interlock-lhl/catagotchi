before do
  if cookies[:page_views]
    cookies[:page_views] = cookies[:page_views].to_i + 1
  else
    cookies[:page_views] = 1
  end
end

helpers do
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user != nil
  end
end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/login' do
  erb :login
end

get '/logout' do
  session.delete(:user_id)
  session[:flash] = 'Bye!'
  redirect '/'
end

post '/session/new' do
  user = User.find_by(email: params[:email])
  if user and user.password == params[:password]
    session[:flash] = "Welcome back #{user.email}! PURR!"
    session[:user_id] = user.id
    redirect '/'
  else
    session[:flash] = 'MEOW! Trouble logging in.'
    redirect '/login'
  end
end

before '/cat' do
  # @cat = current_user.cat
  # unless @cat
  #   User.cat = Cat.new(name: 'Cat')
  #   User.cat.save
  # end
end

get '/cat' do
  erb :cat
end

post '/cat' do
  erb :cat
end

# GET /auth/:provider , /auth/github
get '/auth/:name/callback' do
  auth = request.env['omniauth.auth']
  user = User.find_by(email: auth[:info][:email])
  if user
    session[:user_id] = user.id
  else
    user = User.create(email: auth[:info][:email])
    session[:user_id] = user.id
  end
  session[:flash] = "Logged in via github"
  redirect '/'
  # do whatever you want with the information!
end
