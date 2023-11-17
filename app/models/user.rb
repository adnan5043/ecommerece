class User < ApplicationRecord
  has_many :orders
# ========================product===================
    has_many :products
# ++++++++++++++++++++++++Comment+++++++++++++++++++
 has_many :comments

    # ++++=++++++++++++++++++++ user  device ++++++++++++======

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 mount_uploader :image, FileUploader

  validates :name, presence: true, uniqueness: true
  validates :phone_number, presence: true, format: { with: /\A\d{11}\z/, message: "must be 11 digits" }
  validates_uniqueness_of :phone_number

attr_accessor :phone  # or attr_accessible :phone, if you're using older Rails versions
end
