class Friendship < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  validates :accepted, null: false

  def accept_request
    update_attribute :accepted, true
  end

  def reject_request
    self.destroy
  end

  def self.find_by_users(user1, user2)
    Friendship.find_by(from_user: user1, to_user: user2) ||
    Friendship.find_by(from_user: user2, to_user: user1)
  end

  def sent_by_user?(user)
    from_user == user
  end

  def sent_to_user?(user)
    to_user == user
  end

  def friend_of_user(user)
    user == from_user ? to_user : from_user
  end

  def of_user?(user)
    from_user == user || to_user == user
  end
end
