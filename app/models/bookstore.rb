class Bookstore < ApplicationRecord
    validates :title, {presence: true, length: {maximum: 255}}
    belongs_to :users , optional: true
    has_many :impressions
end
