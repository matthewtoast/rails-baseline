# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: :sessions,
    omniauth_callbacks: :omniauth_callbacks,
  }
  root to: 'home#index'
  get '/logout', to: 'home#logout'
  get '/account', to: 'users#account'
end
