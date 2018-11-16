class Impression < ApplicationRecord
    has_many :comments
    has_many :likes
    belongs_to :bookstore
    belongs_to :user
end
