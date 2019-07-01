Rails.application.routes.draw do
    get 'albums/myalbum'
    get 'discover/discover'
    devise_for :users, controllers: { registrations: 'users' }
    root 'users#feeds'

    resources 'users'
end
