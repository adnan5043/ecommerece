class Product < ApplicationRecord
  belongs_to :user
# ===========================serial number=============
  before_create :generate_serial_number

  private

  def generate_serial_number
    self.serial_number = generate_unique_serial_number
  end

  def generate_unique_serial_number
    loop do
      serial_number = SecureRandom.hex(4).upcase # You can customize this as needed
      break serial_number unless Product.exists?(serial_number: serial_number)
    end
  end


end
