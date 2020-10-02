class ListsController < ApplicationController

    # get lists/new to render a form to create new entry. GET request will show something
    # its job is to render the form page
    get '/lists/new' do
        erb :'lists/new'
     end
    # post lists to create a new list (redirect)
    # show page for a list
    # index route for all lists
end