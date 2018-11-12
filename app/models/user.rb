class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #

  validates :email,:password,:username, presence: true
  validates :username, uniqueness: true
  validates :username, length: {in: 1..10}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: {admin:1, member: 2}

  has_many :houses, dependent: :destroy

  # active storageでavatorを生成
  has_one_attached :avatar
end
