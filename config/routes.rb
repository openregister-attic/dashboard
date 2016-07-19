Rails.application.routes.draw do

  root 'registers#index'

  resources :registers, only: [
      :index,
      :new,
      :create,
      :show,
      :edit,
      :update,
    ] do
  end

  resources :records, only: [
      :new
  ]
end
