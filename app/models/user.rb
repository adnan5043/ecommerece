class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



          validates :name, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{11}\z/, message: "must be 11 digits" }

attr_accessor :phone  # or attr_accessible :phone, if you're using older Rails versions
end
