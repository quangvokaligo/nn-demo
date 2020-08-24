Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :ext do
    resources :webhooks, only: :create
  end

  namespace :int do
    resources :purchase_eraser_transactions, only: :show do
      post :confirm, on: :member
    end
  end
end
