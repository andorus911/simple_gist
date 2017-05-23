class Snippet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true, length: { maximum: 3000 }
  validates :user_id, presence: true
end
