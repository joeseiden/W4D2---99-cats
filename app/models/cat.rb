# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: %w(black white grey calico),
    message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: %w(M F),
    message: "%{value} is not a valid sex" }

  has_many :cat_rental_requests,
    dependent: :destroy


  def age
    now = Date.today
    now.year - birth_date.year - (past_birthday?(now) ? 0 : 1)
  end

  private
  def past_birthday?(date)
    (date.month > birth_date.month || (date.month == birth_date.month && date.day >= birth_date.day))
  end
end
