class Bookstore < ApplicationRecord
    validates :title, {presence: true, length: {maximum: 255}}
    has_many :users
    has_many :impressions
end
