Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations],
                     :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resource :github_webhooks, only: :create, defaults: { formats: :json }
  resource :projects

  root to: "projects#index"
end
