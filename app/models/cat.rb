class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: %w(black white calico),
    message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: %w(M F),
    message: "%{value} is not a valid sex" }

  def age
    now = Date.today
    now.year - birth_date.year - (past_birthday?(now) ? 0 : 1)
  end

  private
  def past_birthday?(date)
    (date.month > birth_date.month || (date.month == birth_date.month && date.day >= birth_date.day))
  end
end
