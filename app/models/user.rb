class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #

  validates :email,:password,:username, presence: true
  validates :username, uniqueness: true, length: {in: 1..30}

  # emailのフォーマットを正規表現で指定
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: {admin:1, member: 2}

  has_many :houses, dependent: :destroy

  # active storageでavatorを生成
  has_one_attached :avatar
end
