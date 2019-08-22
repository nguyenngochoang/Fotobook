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
    get '/switch_photo_album', to:"homes#switch_photo_album", as:'switch_photo_album'
    get '/switch_photo_album_discover', to:"homes#switch_photo_album_discover", as:'switch_photo_album_discover'

    namespace  :admin do
        root 'admin#index'
        resources :photos, only: :index
        resources :albums, only: :index
        resources :users, only: [:index, :edit, :update, :destroy]
    end


    patch '/photo_like/', to:"photos#photo_like", as:'photo_like'
    get 'load_noti', to:"photos#load_noti", as:'load_noti'
    patch '/album_like/', to:"albums#album_like", as:'album_like'
    get '/homegallery', to:"homes#homegallery", as:'homegallery'
    patch '/remove_img', to:"albums#remove_img", as:'remove_img'

    get '/load_feeds', to:"homes#load_feeds", as:'load_feeds'
    get '/load_discover', to:"homes#load_discovers", as:'load_discovers'


    resources :follows, only: [:create, :index, :destroy]



    mount ActionCable.server => '/cable'

end
