Rails.application.routes.draw do

  resources :articles, only: :show
  namespace :admin do
    chronicler_resources :articles
    chronicler_resources :team_members
  end
  mount Manticore::Engine => "/admin"
  root to: "articles#index"
end

