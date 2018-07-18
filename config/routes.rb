Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :v1 do
    resources :game_logs, only: %i[index show]
  end
end
