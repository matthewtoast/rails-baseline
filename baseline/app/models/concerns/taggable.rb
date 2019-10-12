module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings
  end

  def tags_list
    tags.map(&:name)
  end

  def assign_tags(names)
    self.tags = names.map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
end
