class Journey < ApplicationRecord
  belongs_to :direction
  belongs_to :user

  validates :direction, presence: true

  validates :user, presence: true

  validate :_rating_of_range_1_to_5_or_0
  validate :_user_should_not_be_equal_to_direction_user

  def _rating_of_range_1_to_5_or_0
    return unless rating

    if rating < 1
      errors.add :rating, "must be greater than or equal to 1"
    end

    if rating > 5
      errors.add :rating, "must be less than or equal to 5"
    end
  end

  def _user_should_not_be_equal_to_direction_user
    return unless user

    if user == direction.user
      errors.add :user, "should not be equal to direction user"
    end
  end
end
