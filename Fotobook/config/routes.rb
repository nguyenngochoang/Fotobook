Rails.application.routes.draw do
    devise_for :users
    root 'homes#feeds'
    get '/discover', to:"homes#discover", as: 'discover'

    resources :users
    patch '/update_basic', to:"users#update_basic",as:'update_basic'
    patch '/update_password', to:"users#update_password",as:'update_password'
    get '/profiles/me', to:"users#myprofile", as:'me'
    get 'edit_profile', to:"users#edit_profile", as: 'edit_profile'


    get '/task',to:"users#task", as:'task'
    get '/currentgallery', to:"users#currentgallery", as:'currentgallery'
    get '/switchpa', to:"homes#switchpa", as:'switchpa'
    get '/switchpa_discover', to:"homes#switchpa_discover", as:'switchpa_discover'


    patch '/photo_like/:id', to:"photos#photo_like", as:'photo_like'
    patch '/album_like/:id', to:"albums#album_like", as:'album_like'
    get '/homegallery', to:"homes#homegallery", as:'homegallery'


    resources :photos
    resources :albums
    resources :follows, only: [:create, :index, :destroy]
end
