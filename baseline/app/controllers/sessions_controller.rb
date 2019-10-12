# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def new
    redirect_to '/users/auth/google_oauth2'
  end
end
