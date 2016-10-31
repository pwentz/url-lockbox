Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  get '/', to: 'root#index', as: 'root'

  resources :users, only: [:new, :create]

  resources :links, only: [:index]
end
