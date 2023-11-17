class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

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

  def set_unit_price_and_total
    self[:unit_price] = unit_price
    self[:total] = total
  end
end
