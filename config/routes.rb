require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  namespace :api,
    defaults: { format: :json },
    constraints: { subdomain: 'api' },
    path: '/' do
      scope module: :v1,
        constraints: ApiConstraints.new(version: 1, default: true)  do
        resources :users, :only => [:show, :create, :update, :destroy] do
          resources :houses, :only => [:create, :update, :destroy]
        end
        resources :sessions, :only => [:create, :destroy]
        resources :houses, :only => [:show, :index]
      end
    end
end
