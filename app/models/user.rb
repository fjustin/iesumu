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
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]
  enum role: {admin:1, member: 2}

  has_many :houses, dependent: :destroy

  # active storageでavatorを生成
  has_one_attached :avatar

  # DMのためのアソシエーションを記述
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
          uid:      auth.uid,
          provider: auth.provider,
          username: auth.info.username,
          email:    auth.info.email,
          password: Devise.friendly_token[0, 20]
      )
    end

    user
  end
end
