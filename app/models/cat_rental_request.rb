# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED)}
  validates :cat_id, :start_date, :end_date, :status, presence: true

  validate :overlapping_approved_requests, :overlapping_pending_requests
  validate :start_before_end

  belongs_to :cat

  def approve!
    self.status = "APPROVED"

  end

  private
  def overlapping_requests
    overlapping_requests1 = CatRentalRequest.where(cat_id: self.cat_id, start_date: self.start_date..self.end_date).where.not(id: self.id)
    #.or(cat_id: self.cat_id, end_date: self.start_date..self.end_date)
     overlapping_requests2 = CatRentalRequest.where(cat_id: self.cat_id, end_date: self.start_date..self.end_date).where.not(id: self.id)

     overlapping_requests = (overlapping_requests1 + overlapping_requests2)

    overlapping_requests.uniq
  end

  def overlapping_approved_requests
    if overlapping_requests.select{ |request| request[:status] == "APPROVED" } != []
      self.errors[:request]<< "overlaps an approved request"
    end
  end

  def overlapping_pending_requests
    if overlapping_requests.select { |request| request[:status] == "PENDING" } != []
      self.errors[:request]<< "overlaps a pending request"
    end
  end

  def start_before_end
    if self.end_date < self.start_date
      self.errors[:start] << "must be before end"
    end
  end

end
