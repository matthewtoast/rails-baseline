class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  belongs_to :role
  has_many :api_tokens

  def admin?
    role.admin?
  end
end
