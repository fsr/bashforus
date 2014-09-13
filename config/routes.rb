Rails.application.routes.draw do
  devise_for :users
  shallow do
    resources :channels, only: [ :new, :create ]
    authenticate :user, lambda { |u| u.has_role? :admin } do
      resources :channels, except: [ :new, :create ] do
        member do
          put :approve
          put :activate
          put :deactivate
        end
      end
    end
    resources :quotes do
      match '/like', to: 'likes#create', via: :post
      match '/dislike', to: 'dislikes#create', via: :post
    end
    resources :by, controller: 'nicknames'
    resources :tag, controller: 'tags'
  end

  match '/', to: 'channels#index', constraints: { subdomain: '' }, via: [:get, :post, :put, :patch, :delete]
  match '/', to: 'channels#show', constraints: { subdomain: /.+/ }, via: [:get, :post, :put, :patch, :delete]
  root to: 'channels#index'
end
