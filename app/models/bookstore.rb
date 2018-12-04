class Bookstore < ApplicationRecord
    attr_accessor :thumbnailobject

    validates :author, presence: true #author, title の空投稿を防いでいる
    validates :title, {presence: true, length: {maximum: 255}}
    validates :thumbnail, presence: true

    has_one_attached :thumbnail

    belongs_to :users  , optional: true
    #optional: trueはnilを許容するバリデーション
    has_many :impressions


    # scope :search_by_title, ->(title) {
    #     where("title like '%#{title}%'")
    # }
end
