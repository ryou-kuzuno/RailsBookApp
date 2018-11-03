class Bookstore < ApplicationRecord
    validates :title, {presence: true, length: {maximum: 255}}
    belongs_to :user
    belongs_to :like
    belongs_to :comment
end
