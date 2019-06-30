Rails.application.routes.draw do
    get 'albums/myalbum'
    get 'discover/discover'
    devise_for :users
    root 'welcome#feeds'
end
