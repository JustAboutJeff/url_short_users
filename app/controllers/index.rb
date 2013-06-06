get '/' do
  erb :index
end


get '/login' do
  erb :login
end

post '/login' do
  @user = User.authenticate(params[:email],params[:password])
  puts "BEFORE PASSING TO CONDITIONAL #{@user}"
  if @user
    puts "AFFFFFFFTER PASSING TO CONDITIONAL #{@user}"
    session[:id] = @user.id 
    redirect to '/profile'
  else
    redirect to '/'
  end
end

get '/logout' do
  session.clear
  redirect to '/'
end

get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.new(params)
  if @user.save
    redirect to '/'
  else
    @errors = @user.errors
    erb :signup
  end
end

get '/profile' do
  if session[:id]
    @url_list = Url.find_all_by_user_id(session[:id])
    erb :index
  else
    redirect to '/'
  end
end

# dave@runolfon.net

post '/urls' do
  @new_url = Url.create(params)
  if @new_url.valid?
    @errors = nil
    @url_list = Url.all
    erb :index
  else
    @errors = @new_url.errors.messages
    erb :index
  end

end

get '/:short_url' do
  @clicked_url = Url.find_by_short_url(params[:short_url])
  @clicked_url.click_count += 1
  @clicked_url.save
  redirect "#{@clicked_url.long_url}"
end

