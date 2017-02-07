Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :articles, only: [:index, :show, :create, :update, :destroy]
    resources :users, only: [:create, :show] do
      get 'bad_worker'
    end

    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
end
