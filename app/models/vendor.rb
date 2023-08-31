class Vendor < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed."}
  validates :contact_name, presence: true, allow_blank: false
  validates :contact_phone, presence: true, allow_blank: false
  validates :credit_accepted, presence: true, allow_blank: false, inclusion: [true, false]

  has_many :market_vendors, dependent: :destroy
  has_many :markets, through: :market_vendors
end