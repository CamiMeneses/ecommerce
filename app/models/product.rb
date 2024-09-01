class Product < ApplicationRecord
  has_many_attached :images

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 3 }
  validates :price, presence: true

  belongs_to :category
end
