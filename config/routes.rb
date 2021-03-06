NgSocial::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, skip: :all
  root to: "home#index"

  namespace "api", defaults: { format: :json } do
    scope "v1" do
      # resources :messages

      devise_scope :user do
        post "login" => "sessions#create", as: :login
        post "logout" => "sessions#destroy", as: :destroy
        post "signup" => "registrations#create", as: :signup
        post "update_profile" => "registrations#update", as: :update_profile
        get "current_user" =>"users#show_current_user", as: :current_user
      end

      resources :users, only: [:show, :index] do
        member do
          get :friends
        end
        resources :posts, except: [:new, :edit] do
          collection do
            get "favorites" => "users#favorite"
          end
        end
      end

      post "attachments" => "attachments#create"
      post "attachments/:id/destroy" => "attachments#destroy"

      post "posts/upload_image" => "posts#upload_image"
      get "posts/:id/favorite" => "posts#favorite"
      get "posts/:id/unfavorite" => "posts#unfavorite"
    end
  end

  # get "*path" => 'home#index', as: 'catchall'
end
