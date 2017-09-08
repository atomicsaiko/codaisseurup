class Event < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :photos
  has_many :registrations, dependent: :destroy
  has_many :guests, through: :registrations, source: :user

  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  #validates :end_date_after_start_date

  def end_date_after_start_date?
    if ends_at > starts_at
      errors.add :ends_at, "must be after start date"
    end
  end

  def bargain?
    price < 30
  end

  def self.order_by_price
    order :price
  end
end
