module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  VALID_VOTE_KINDS = %w(up down)

  def vote!(user_id, kind)
    unless VALID_VOTE_KINDS.include?(kind)
      raise StandardError.new("'#{kind}' is not a valid kind of vote")
    end

    Vote.create!(
      voter_id: user_id,
      votable_id: id,
      votable_type: self.class.name,
      kind: kind,
    )
  end
end
