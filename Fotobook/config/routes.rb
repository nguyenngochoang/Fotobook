Rails.application.routes.draw do
    get 'albums/myalbum'
    get 'discover', to:"discover#discover"
    devise_for :users
    root 'users#feeds'

    resources 'users'
    get '/profiles/me', to:"users#myprofile", as:'me'
    get '/task',to:"users#task", as:'task'
    get '/currentgallery', to:"users#currentgallery", as:'currentgallery'
    get '/follow', to:"users#follow", as:'follow'
    get 'follow_action', to:"users#follow_action", as:'follow_action'
end
