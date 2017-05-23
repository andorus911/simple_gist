class Comment < ApplicationRecord
  belongs_to :snippet
  default_scope -> { order('created_at DESC') } # DESCending order
  validates :user_id, presence: true
  validates :snippet_id, presence: true
  validates :comments, presence: true, length: { maximum: 500 }
end
