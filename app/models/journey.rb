class Journey < ApplicationRecord
  belongs_to :direction
  belongs_to :user

  validates :direction, presence: true

  validates :user, presence: true

  validates_inclusion_of :rating, in: 1..5

  validate :_user_should_not_be_equal_to_direction_user

  def _user_should_not_be_equal_to_direction_user
    return unless user

    if user == direction.user
      errors.add :user, "should not be equal to direction user"
    end
  end
end
