class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  belongs_to :role
  has_many :api_tokens

  default_scope {
    includes(:role).order('family_name ASC')
  }

  def as_json(*)
    {
      id: id,
      slug: slug,
      given_name: given_name,
      family_name: family_name,
    }
  end

  def full_name
    "#{given_name} #{family_name}"
  end

  def admin?
    role.admin?
  end

  class << self
    def seek(first, last, limit = 10, like = 'ILIKE')
      by_full_name = User.where("given_name #{like} ? AND family_name #{like} ?", "#{first}%", "#{last}%").limit(limit)
      by_family_name = User.where("family_name #{like} ?", "#{first}%").limit(limit)
      by_given_name = User.where("given_name #{like} ?", "#{first}%").limit(limit)
      by_email = User.where("email #{like} ?", "#{first}%").limit(limit)
      by_email | by_full_name | by_family_name | by_given_name
    end
  end
end
