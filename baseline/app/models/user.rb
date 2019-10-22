class User < ApplicationRecord
  include Sluggable

  devise :omniauthable, omniauth_providers: [:google_oauth2]
  belongs_to :role
  has_many :api_tokens

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  default_scope {
    includes(:role).order('family_name ASC')
  }

  def as_json(opts = {})
    {
      id: id,
      slug: slug,
      given_name: given_name,
      family_name: family_name,
      picture_url: picture_url,
      bio: bio,
      location: location,
      role: role.as_json(opts),
      is_current_user: opts[:current_user] == self,
    }
  end

  def full_name
    "#{given_name} #{family_name}"
  end

  alias slug_source full_name

  def admin?
    role.admin?
  end

  def friend?(user)
    friends.include?(user)
  end

  def inverse_friend?(user)
    inverse_friends.include?(user)
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
