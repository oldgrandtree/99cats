class Cat < ActiveRecord::Base
  COLORS = %w(brown white black orange gray)

  validates :age, :name, :birth_date, :color, :name, :sex, presence: true
  validates :age, numericality: { only_integer: true }
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: ['M', 'F'] }

  has_many :cat_rental_requests, dependent: :destroy
end
