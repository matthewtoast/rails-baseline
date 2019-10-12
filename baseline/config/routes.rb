# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: :sessions,
    omniauth_callbacks: :omniauth_callbacks,
  }
  root to: 'home#index'
end
