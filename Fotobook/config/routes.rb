Rails.application.routes.draw do
    get 'albums/myalbum'
    get 'discover', to:"discover#discover"
    devise_for :users
    root 'users#feeds'

    resources :users
    patch '/update_basic', to:"users#update_basic",as:'update_basic'
    patch '/update_password', to:"users#update_password",as:'update_password'
    get '/profiles/me', to:"users#myprofile", as:'me'
    get '/newphoto', to:"users#new_photo", as:'newphoto'
    get 'edit_profile', to:"users#edit_profile", as: 'edit_profile'
    get '/add_photo', to:"users#add_photo", as:'add_photo'
    post '/add_photo_action', to:"users#add_photo_action", as:'add_photo_action'
    get '/task',to:"users#task", as:'task'
    get '/currentgallery', to:"users#currentgallery", as:'currentgallery'
    get '/follow', to:"users#follow", as:'follow'
    get 'follow_action', to:"users#follow_action", as:'follow_action'
end
