class Journey < ApplicationRecord
  belongs_to :direction
  belongs_to :user

  validates :direction, presence: true

  validates :user, presence: true

  validates_inclusion_of :rating, in: 1..5
end
