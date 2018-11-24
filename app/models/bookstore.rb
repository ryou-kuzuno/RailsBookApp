class Bookstore < ApplicationRecord
    validates :author, presence: true
    validates :title, {presence: true, length: {maximum: 255}}
    belongs_to :users , optional: true
    has_many :impressions
#  if search
#         Post.where(['content LIKE ?', "%#{search}%"])
#     end
   
end
