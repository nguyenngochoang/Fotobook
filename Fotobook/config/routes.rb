Rails.application.routes.draw do
    get 'discover', to:"discover#discover"
    devise_for :users
    root 'users#feeds'

    resources :users
    patch '/update_basic', to:"users#update_basic",as:'update_basic'
    patch '/update_password', to:"users#update_password",as:'update_password'
    get '/profiles/me', to:"users#myprofile", as:'me'
    get 'edit_profile', to:"users#edit_profile", as: 'edit_profile'


    get '/task',to:"users#task", as:'task'
    get '/currentgallery', to:"users#currentgallery", as:'currentgallery'

    resources :photos
    resources :albums
    resources :follows, only: [:create, :index, :destroy]
end
