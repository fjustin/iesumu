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

  class << self
    def find_or_create_for_oauth(auth)
      find_or_create_by!(email: auth.info.email) do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.name
        user.email = auth.info.email
        downloaded_image = open(auth.info.image)
        user.avatar.attach(io: downloaded_image, filename: 'avatar.jpg', content_type: downloaded_image.content_type)
        password = Devise.friendly_token[0..5]
        logger.debug password
        user.password = password
      end
    end

    def new_with_session(params, session)
      if user_attributes = session['devise.user_attributes']
        new(user_attributes) { |user| user.attributes = params }
      else
        super
      end
    end
  end
end
