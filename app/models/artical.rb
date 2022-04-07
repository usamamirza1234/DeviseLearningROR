class Artical < ApplicationRecord
  has_many :comments, as: :commentable
end
