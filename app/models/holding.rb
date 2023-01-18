class Holding < ApplicationRecord
  belongs_to :portfolio
  has_many :transactions, dependent: :destroy

  validates :symbol, presence: true
end
