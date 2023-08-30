class Vendor < ApplicationRecord
  validates_presence_of   :name,
                          :description,
                          :contact_name,
                          :contact_phone,
                          :credit_accepted
  # validates_inclusion_of  :credit_accepted, in: [true, false]

  has_many :market_vendors, dependent: :destroy
  has_many :markets, through: :market_vendors
end