class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :text, length: { maximum: 2000 }
end
