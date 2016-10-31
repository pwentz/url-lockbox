Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  get '/', to: 'root#index', as: 'root'

  resources :users, only: [:new, :create]

  resources :links, only: [:index]

  post '/links', to: 'links#create', as: 'link'

  get '/sign_in', to: 'sessions#new', as: 'new_session'
  post '/sign_in', to: 'sessions#create', as: 'session'
  delete '/sign_out', to: 'sessions#destroy'

  namespace :api do
    namespace :v1 do
      resources :links, only: [:index]
      put '/links/:id', to: 'links#update'
    end
  end
end
