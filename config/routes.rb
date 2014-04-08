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
        resources :posts, except: [:new, :edit]
      end

    end
  end

  # get "*path" => 'home#index', as: 'catchall'
end
