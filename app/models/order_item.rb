class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validate :product_belongs_to_other_user
  before_save :set_unit_price_and_total

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end
  def total
    quantity * product.price
  end

  private

  def product_belongs_to_other_user
    if product.user == order.user
      errors.add(:base, "You cannot add your own products to your cart")
    end
  end
  def set_unit_price_and_total
    self[:unit_price] = unit_price
    self[:total] = total
  end
end
