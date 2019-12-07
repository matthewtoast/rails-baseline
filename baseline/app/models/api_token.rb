class ApiToken < ApplicationRecord
  belongs_to :user

  default_scope do
    includes(:user)
  end
end
