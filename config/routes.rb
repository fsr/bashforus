Rails.application.routes.draw do
  devise_scope :user do
    post 'users/pushover/test', to: 'registrations#pushover_test', as:  'user_registration_pushover_test'
    post 'users/xmpp/test', to: 'registrations#xmpp_test', as:  'user_registration_xmpp_test'
    post 'users/color/:color', to: 'registrations#set_color', as: 'user_color'
  end
  devise_for :users, :controllers => { registrations: 'registrations' }
  shallow do
    resources :channels, only: [ :new, :create ]
    get :contact, to: 'contacts#new', as: :contact
    post :contact, to: 'contacts#create'
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
        resource :channel, only: [ :edit, :update ] do
          collection do
            put :membership, to: 'channels#membership'
          end
        end
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
        delete :like, to: 'likes#destroy'
        delete :dislike, to: 'dislikes#destroy'
      end
      resources :comments
    end
    resources :by, controller: 'nicknames' do
      member do
        post :claim
        post :revert
      end
    end
    resources :tag, controller: 'tags'
    resources :moment, controller: 'moments'
  end

  match '/', to: 'channels#index', constraints: { subdomain: '' }, via: [:get, :post]
  match '/', to: 'quotes#index', constraints: { subdomain: /.+/ }, via: :get
  root to: 'channels#index'
end
