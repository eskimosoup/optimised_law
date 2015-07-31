Rails.application.routes.draw do
  resources :articles, only: :show
  resources :academy_entries, only: [:index, :show], path: 'academy' do
    member do
      post 'create', as: 'download', to: 'academy_entry_downloads#create'
      get 'thank-you', as: 'thank_you', to: 'academy_entry_downloads#show'
    end
  end
  resources :marketing_assessment_signups, only: [:new, :create]

  namespace :admin do
    chronicler_resources :academy_entries
    chronicler_resources :articles
    chronicler_resources :team_members
  end

  mount Manticore::Engine => "/admin"
  root to: "articles#index"
end
