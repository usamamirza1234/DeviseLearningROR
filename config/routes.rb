Rails.application.routes.draw do
  resources :demos
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    mailer: 'users/mailer',
  }
  root 'home#index'
  get '/confirmation_pending' => 'home#after_registration_path'

  namespace :admin do
    resources :students
    resources :projects
    resources :courses
    resources :blogs
    get 'dashboard' => 'dashboard#index'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
