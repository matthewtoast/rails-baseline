class Role < ApplicationRecord
  USER = 'user'.freeze
  ADMIN = 'admin'.freeze

  has_many :users

  def admin?
    name == Role::ADMIN
  end

  class << self
    def user
      Role.find_by(name: Role::USER)
    end

    def admin
      Role.find_by(name: Role::ADMIN)
    end
  end
end
