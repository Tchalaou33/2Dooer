class UsersController < ApplicationController

  # What routes do I need for login?
  # the purpose of this route is tosh render the login page (form)
  get '/login' do
    erb :login
    end
    
  #the purpose of this route is to receive the login form,
  # find the user, and log the user in (create a session)(Key Value Pair)
  post '/login' do 
    #find the user
    @user = User.find_by(email: params[:email])
    #Authenticate the user - verify user is who they say they are # they have the right credentials -email/password combo
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id # actually logging the user in
      puts session
      redirect "users/#{@user.id}"
      #Log the user in - create the user session
      #redirect to the user's landing page (show? index? dashboard?)

    else
      # tell the user they entered invalid credentials
      #redirect them to the login page
    end 
  end

    # What routes do I need for signup?
    # this route's job is to render the signup form
  get '/signup' do
    # erb (render) a view
    erb :signup
  end

  post '/users' do
      #here is where we will create a new user and persist the new
      #user to the DB
      #params will look like this: 
      #{
      #    "name"=>"Ann",
      #    "email"=>"Gmail@g.com",
      #    "password"=>"password"
      #}
      #I only want to persist a user that has a name, email, AND password
      if params[:name] != "" && params[:email] != "" && params[:password] != ""
        #valid input
        @user = User.create(params)
        session[:user_id] = @user.id
        #where do I go now?
        #Lets go to the user show page: Develper"s choice
        redirect "/users/#{@user.id}"
      else
        #not vaild input
        #it would be better to include a message to the user
        #telling them what is wrong
        redirect '/signup'
      end
    end

    #user SHOW route
    get '/users/:id' do
        #what do I need to do first?
        #raise params.inspect
        @user = User.find_by(id: params[:id])

        erb :'/users/show'
    end

    get '/logout'do
      session.clear
      redirect '/'
    end

end
