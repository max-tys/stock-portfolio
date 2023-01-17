class Holding < ApplicationRecord
  belongs_to :portfolio

  validates :symbol, presence: true
end
