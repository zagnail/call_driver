class User < ApplicationRecord
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :mobile_phone_number, presence: true, uniqueness: true
end
