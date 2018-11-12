class House < ApplicationRecord
  validates :name,:content, presence: true
  validates :name, length: { maximum: 50 }

  belongs_to :user
  has_many_attached :images

end
