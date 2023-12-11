class PromoCode < ApplicationRecord

# belongs_to:order
    validates :code, presence: true, uniqueness: true, format: { with: /\A[A-Z0-9]+\z/ }, length: { in: 4..10 }
  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :valid_til, presence: true


end
