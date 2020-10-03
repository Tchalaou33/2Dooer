class ListsController < ApplicationController

    # get lists/new to render a form to create new entry. GET request will show something
    # its job is to render the form page
    get '/lists/new' do
        erb :'lists/new'
     end
    # post lists to create a new list (redirect)
    post '/lists' do
        # I want to create a new list and save it to the DB
        # I only want to save list if it has some content
        # Only want to create a list if user is logged in
        if !logged_in?
            redirect '/'
        end

        if params[:content] !=""
            #create a new list
            @list = List.create(content: params[:content],
            user_id: current_user.id)
            redirect "/lists/#{@list.id}"

        else
            redirect '/lists/new'
        end
    end

    # show page for a list
    # dynamic route/ 
    get '/lists/:id' do
        @list = List.find(params[:id])
        erb :'lists/show'
    end

    # This route should send us to lists/edit.erb, which will
    # render a edit form
    get '/lists/:id/edit' do
        erb :'/lists/edit'
      end
    # index route for all lists
end