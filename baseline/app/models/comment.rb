class Comment < ApplicationRecord
  belongs_to :commenter, class_name: 'User'
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, class_name: 'Comment'
end
