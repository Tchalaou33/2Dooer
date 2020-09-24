class UsersController < ApplicationController

    # What routes do I need for login?
    # the purpose of this route is tosh render the login page (form)
    get '/login' do
        erb :login
    end
    
    #the purpose of this route is to receive the login form,
    # find the user, and log the user in (create a session)
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
    get '/signup' do

    end

    #user SHOW route
    get '/users/:id' do
        "this will be the user show route"
    end
end