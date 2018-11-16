class User < ApplicationRecord
    belongs_to :bookstore , optional: true
    has_many :impressions
    has_many :likes
end
