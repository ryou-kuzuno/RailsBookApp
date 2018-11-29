class Bookstore < ApplicationRecord
    validates :author, presence: true #author, title の空投稿を防いでいる
    validates :title, {presence: true, length: {maximum: 255}}

    belongs_to :users  , optional: true
    #optional: trueはnilを許容するバリデーション
    has_many :impressions

    def self.search(search) #ここでのself.はUser.を意味する
        if search
          where(['content LIKE ?', "%#{search}%"]) #検索とcontentの部分一致を表示
        else
          all #全て表示。User.は省略
        end
    end
    
#  if search
#         Post.where(['content LIKE ?', "%#{search}%"])
#     end
    # scope :search_by_title, ->(title) {
    #     where("title like '%#{title}%'")
    # }
end
