class UsersController < ApplicationController

    # What routes do I need for login?
    # the purpose of this route is tosh render the login page (form)
    get '/login' do
        erb :login

    end
    # What routes do I need for signup?
    get '/signup' do

    end

end