class Transaction < ApplicationRecord
  belongs_to :holding

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
end
