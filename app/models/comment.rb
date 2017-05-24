class Comment < ApplicationRecord
  belongs_to :snippet
  belongs_to :user
  default_scope -> { order('created_at DESC') } # DESCending order
  validates :user_id, presence: true
  validates :snippet_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }
end
