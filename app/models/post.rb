class Post < ApplicationRecord
  validates :text, length: { in: 5..2000 }, presence: true #, format: { with: /\A[a-zA-Z0-9]\z/ }
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments
end
