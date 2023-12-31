class Market < ApplicationRecord
  validates_presence_of   :name,
                          :street,
                          :city,
                          :county,
                          :state,
                          :zip,
                          :lat,
                          :lon,
                          :vendor_count

  has_many :market_vendors, dependent: :destroy
  has_many :vendors, through: :market_vendors

  def vendor_count
    self.vendors.count
  end
end