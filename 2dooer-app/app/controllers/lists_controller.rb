class ListsController < ApplicationController

    get '/lists' do
        @lists = List.all
        erb :'lists/index'
    end

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
        set_list
        erb :'lists/show'
    end

      #** MAJOR PROBLEMS!!***
      # RIGHT NOW, ANYONE CAN EDIT ANYONE ELSE'S LIST!!!
      # ALSO, I CAN EDIT A JOURNAL ENTRY TO BE BLANK!!


    # This route should send us to lists/edit.erb, which will
    # render a edit form
    get '/lists/:id/edit' do
        set_list
        if logged_in?
            if @list.user == current_user
                erb :'/lists/edit'
            else
                redirect "users/#{current_user.id}"
            end
        else
            redirect'/'
        end
    end

      # This action's job is to ...??
    patch '/lists/:id' do
        #1. find the list 
        set_list
        if logged_in?

            if @list.user == current_user
            #2. modify (update) list
                @list.update(content: params[:content])
        #3. redirect to show page
                redirect "/lists/#{@list.id}"
            else
                redirect "users/#{current_user.id}"
            end
        end
    end
    # index route for all lists

    private

    def set_list
        @list = List.find(params[:id])  
    end

end