class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :user_id, presence: true
  validates :status, inclusion: { in: ['PENDING', 'APPROVED', 'DENIED'] }
  validate :not_overlapping

  before_validation :set_status

  belongs_to :cat
  belongs_to :user

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      self.save!

      overlapping_requests.each do |request|
        next if request.id == self.id
        request.deny!
      end
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  def pending?
    self.status == "PENDING"
  end

  private

  def set_status
    status ||= "PENDING"
  end

  def not_overlapping
    if self.status != "DENIED" && overlapping_approved_requests.any?
      errors[:base] << "The request overlaps with existing approved request"
    end
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_requests
    sql_overlap = <<-SQL
    (:start_date BETWEEN start_date AND end_date)
    OR
    (:end_date BETWEEN start_date AND end_date)
    OR
    (start_date BETWEEN :start_date AND :end_date)
    SQL

    CatRentalRequest
      .where(cat_id: cat_id)
      .where(sql_overlap, start_date: start_date, end_date: end_date)
  end
end
