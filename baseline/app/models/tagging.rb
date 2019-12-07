class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
  belongs_to :tagger, class_name: 'User', optional: true
end
