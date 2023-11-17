class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user
  # other order model code...

  scope :in_progress, -> { where(status: 'in_progress') }
  before_save :set_subtotal

  def calculate_subtotal
    order_items.collect { |order_item| order_item.valid? ? order_item.total : 0 }.sum
  end

  private

  def set_subtotal
    self.subtotal=calculate_subtotal
  end
end

