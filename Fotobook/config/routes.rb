Rails.application.routes.draw do
    get 'albums/myalbum'
    get 'discover', to:"discover#discover"
    devise_for :users, controllers: { registrations: 'users' }
    root 'users#feeds'

    resources 'users' do
        member do
            get 'myprofile'
        end
    end
    get '/profiles/me', to:"users#myprofile", as:'me'
   
end
