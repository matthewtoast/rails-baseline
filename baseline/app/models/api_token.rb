class ApiToken < ApplicationRecord
  belongs_to :user

  default_scope {
    includes(:user)
  }
end
