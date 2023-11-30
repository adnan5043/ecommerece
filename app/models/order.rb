class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user
  has_many :payments
  # other order model code...

  scope :in_progress, -> { where(status: 'in_progress') }
  before_save :set_subtotal

  def update_subtotal
    self.subtotal = calculate_subtotal
    save
  end

  def calculate_subtotal
    order_items.sum(&:total)
  end

  private

  def set_subtotal
    self.subtotal = calculate_subtotal
  end
end
