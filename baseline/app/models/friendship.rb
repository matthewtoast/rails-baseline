class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  default_scope do
    includes(:user, :friend)
  end
end
