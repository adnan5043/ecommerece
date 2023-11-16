class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product


 validates :content, presence: true

  # Custom validation to ensure a user cannot comment on his own product
  validate :user_cannot_comment_on_own_product

  def user_cannot_comment_on_own_product
    errors.add(:user, "can't comment on own product") if user_id == product&.user_id
  end
end
