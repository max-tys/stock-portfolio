class Portfolio < ApplicationRecord
  has_many :holdings, dependent: :destroy

  validates :name, presence: true
end
