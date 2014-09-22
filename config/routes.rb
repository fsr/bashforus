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
      namespace :admin do
        resources :users
      end
      resource :role do
        collection do
          match '/grant/:user_id/:role', to: 'role#grant', via: :post, as: :grant
          match '/revoke/:user_id/:role', to: 'role#revoke', via: :post, as: :revoke
        end
      end
    end
    resources :quotes do
      member do 
        post :disable
        post :enable
        post :like, to: 'likes#create'
        post :dislike, to: 'dislikes#create'
      end
    end
    resources :by, controller: 'nicknames'
    resources :tag, controller: 'tags'
  end

  match '/', to: 'channels#index', constraints: { subdomain: '' }, via: [:get, :post]
  match '/', to: 'quotes#index', constraints: { subdomain: /.+/ }, via: :get
  root to: 'channels#index'
end
