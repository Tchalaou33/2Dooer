class ListsController < ApplicationController

    get '/lists' do
        @lists = List.all
        erb :'lists/index'
    end

    get '/lists/new' do
        erb :'lists/new'
     end
   
    post '/lists' do
        if !logged_in?
            redirect '/'
        end

        if params[:content] !=""
            @list = List.create(content: params[:content],
            user_id: current_user.id)
            redirect "/lists/#{@list.id}"

        else
            redirect '/lists/new'
        end
    end

    get '/lists/:id' do
        set_list
        erb :'lists/show'
    end

    get '/lists/:id/edit' do
        set_list
        if logged_in?
            if authorized_to_edit?(@list)
                erb :'/lists/edit'
            else
                redirect "users/#{current_user.id}"
            end
        else
            redirect'/'
        end
    end

    patch '/lists/:id' do 
        set_list
        if logged_in?

            if authorized_to_edit?(@list) && params[:content] != ""
                @list.update(content: params[:content])
                redirect "/lists/#{@list.id}"
            else
                redirect "users/#{current_user.id}"
            end
        else
            redirect '/'
        end
    end

    delete '/lists/:id' do
        set_list
        if authorized_to_edit?(@list)
            @list.destroy
            redirect '/lists'
        else
            redirect '/lists'

        end
    end

    private

    def set_list
        @list = List.find(params[:id])  
    end

end