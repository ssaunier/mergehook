Rails.application.routes.draw do
  resources :projects

  devise_for :users, :skip => [:registrations],
                     :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resource :github_webhooks, only: :create, defaults: { formats: :json }

  root to: "projects#index"
end
