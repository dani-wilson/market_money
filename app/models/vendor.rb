class Vendor < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed."}
  validates :contact_name, presence: true
  validates :contact_phone, presence: true
  validates :credit_accepted, presence: true, inclusion: [true, false]

  has_many :market_vendors, dependent: :destroy
  has_many :markets, through: :market_vendors
end