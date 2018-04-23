Rails.application.routes.draw do
  namespace :contacts do
    resources :people
    resources :organizations
  end

  resources :cases
  resources :people
  resources :organizations

  root to: "cases#index"
end
