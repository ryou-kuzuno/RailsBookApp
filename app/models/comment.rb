class Comment < ApplicationRecord
    belongs_to :bookstore , optional: true
end
