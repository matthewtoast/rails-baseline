# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth_hash = request.env['omniauth.auth']
    raw_info = auth_hash['extra']['raw_info']
    email = raw_info['email']

    user = User.where(email: email).first_or_initialize
    user.role_id = admin_email?(user.email) ? Role.admin.id : Role.user.id

    user.save!
    sign_in user
    redirect_to root_path
  end
end

def admin_email?(email)
  email =~ (ENV['ADMIN_EMAILS'] || '').split(',').include?(email)
end