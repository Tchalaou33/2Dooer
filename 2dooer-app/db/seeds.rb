


List.destroy_all
User.destroy_all
andrea = User.create(name: "Andrea", email: "jam@Molay.com", password: "password")
jim = User.create(name: "Jim", email: "jim@apple.com", password: "password")


 
List.create(content: "Project to complete To Day", user_id: andrea.id )



andrea.lists.create(content: "We are building a Sinatra app! Yaaay!")

jims_list = jim.lists.build(content: "It's super cold in VA!!!")
jims_list.save