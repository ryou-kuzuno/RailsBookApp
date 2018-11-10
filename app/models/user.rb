class User < ApplicationRecord
    belongs_to :bookstore , optional: true
end
