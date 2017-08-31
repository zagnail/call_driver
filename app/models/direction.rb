class Direction < ApplicationRecord

  belongs_to :user

  validates :distance, presence: true
  validates :duration, presence: true
  validates :end_address, presence: true
  validates :start_address, presence: true
  validates :end_location, presence: true
  validates :start_location, presence: true
  validates :start_date, presence: true
  validates :cost, presence: true
  validates :user, presence: true

  validate :_start_date_after_todays_date

  def _start_date_after_todays_date
    return unless start_date

    if start_date <= Time.now
      errors.add :start_date, "must be greater than now"
    end
  end

end
