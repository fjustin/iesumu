class House < ApplicationRecord
  # enumerizeでstatusを管理
  extend Enumerize

  # 1を募集中、2を居住中、デフォルトを1とする。スコープとして指定するので募集ページと居住ページで分ける予定
  enumerize :status,in: [ :empty, :full ],default: :empty, scope: true

  validates :name,:content,:price,:member,:address,:station, presence: true
  validates :name, length: { maximum: 50 }

  belongs_to :user
  belongs_to :station
  has_many_attached :images

end
