Rails.application.routes.draw do

  root 'registers#index'

  resources :registers, only: [
      :index,
    ]
end
