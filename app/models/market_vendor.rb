class MarketVendor < ApplicationRecord
  validates :market_id, presence: true, allow_blank: false
  validates :vendor_id, presence: true, allow_blank: false
  validates :market_id, uniqueness: { scope: :vendor_id }

  belongs_to :vendor
  belongs_to :market
end