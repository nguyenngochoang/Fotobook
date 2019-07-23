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

    namespace  :admins do
        resources :photos, only: :index
        # get 'album_index', to:"manage_albums#album_index", as: 'album_index'
        # resources :ad_albums, only: :index
        resources :albums, only: :index
        resources :users, only: [:index, :edit, :update, :destroy]
        # get 'user_index', to:"manage_users#user_index", as: 'user_index'
        # get 'admin_edit_user/:id', to:"manage_users#admin_edit_user", as:'admin_edit_user'
        # patch 'update_basic_user/:id', to:"manage_users#update_basic_user", as:'update_basic_user'
    end


    patch '/photo_like/:id', to:"photos#photo_like", as:'photo_like'
    patch '/album_like/:id', to:"albums#album_like", as:'album_like'
    get '/homegallery', to:"homes#homegallery", as:'homegallery'
    patch '/remove_img', to:"albums#remove_img", as:'remove_img'

    resources :photos
    resources :albums
    resources :follows, only: [:create, :index, :destroy]
end
