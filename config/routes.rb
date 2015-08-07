Rails.application.routes.draw do
  resources :articles, only: :show
  resources :academy_entries, only: [:index, :show], path: 'academy' do
    member do
      post 'create', as: 'download', to: 'academy_entry_downloads#create'
      post 'subscribe', as: 'mailchimp_subscription', to: 'mailchimp_subscriptions#create'
      get 'thank-you', as: 'thank_you', to: 'academy_entry_downloads#show'
    end
  end
  resources :marketing_assessment_signups, only: [:new, :create], path: 'free-internet-marketing-assessment'

  namespace :admin do
    manticore_resources :mailchimp_subscriptions
    manticore_resources :academy_entry_downloads
    manticore_resources :seo_entries do
      get 'rebuild_seo', on: :collection
    end
    chronicler_resources :academy_entries
    chronicler_resources :articles
    chronicler_resources :team_members
  end

  mount Manticore::Engine => "/admin"
  root to: "articles#index"
end
