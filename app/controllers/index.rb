get '/' do
  erb :index
end

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
