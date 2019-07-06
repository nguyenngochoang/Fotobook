Rails.application.routes.draw do
    get 'albums/myalbum'
    get 'discover', to:"discover#discover"
    devise_for :users
    root 'users#feeds'

    resources 'users' do
        member do
            get 'myprofile'
        end
    end
    get '/profiles/me', to:"users#myprofile", as:'me'
    get '/task',to:"users#task", as:'task'
    get '/currentgallery', to:"users#currentgallery", as:'currentgallery'
    get '/users/sign_up(.:format)', to:"devise/registration#new", as:'new_user_signup'
end
