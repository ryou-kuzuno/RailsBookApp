class Bookstore < ApplicationRecord
    attr_accessor :thumbnailobject

    validates :author, presence: true #author, title の空投稿を防いでいる
    validates :title, {presence: true, length: {maximum: 255}}

    # 一時的に制約を外しています
    # validates :thumbnail, presence: true

    belongs_to :users  , optional: true
    #optional: trueはnilを許容するバリデーション
    has_many :impressions


    # scope :search_by_title, ->(title) {
    #     where("title like '%#{title}%'")
    # }


    # モデルに1つの画像を添付するには、has_one_attachedを使う
    # Active Storageをつかうと、画像用のカラムを用意する必要がない
    has_one_attached :image
end
