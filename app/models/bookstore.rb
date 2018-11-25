class Bookstore < ApplicationRecord
    validates :author, presence: true #author, title の空投稿を防いでいる
    validates :title, {presence: true, length: {maximum: 255}

    belongs_to :users , optional: true
    has_many :impressions
#  if search
#         Post.where(['content LIKE ?', "%#{search}%"])
#     end

end
