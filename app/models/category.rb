class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }

  has_many :products, dependent: :restrict_with_exception
end
