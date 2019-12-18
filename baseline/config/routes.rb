# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: :sessions,
    omniauth_callbacks: :omniauth_callbacks,
  }
  root to: 'home#index'
  get '/account', to: 'accounts#show'
  get '/accounts/logout', to: 'accounts#logout'
end
