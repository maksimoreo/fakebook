class Friendship < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  validates :accepted, null: false
  validates :from_user, uniqueness: { scope: :to_user }

  validate :cannot_add_self
  validate :alternative_request

  def accept_request
    return false if accepted?
    update_attribute :accepted, true
  end

  def reject_request
    self.destroy
  end

  def self.find_by_users(user1, user2)
    Friendship.find_by(from_user: user1, to_user: user2) ||
    Friendship.find_by(from_user: user2, to_user: user1)
  end

  def self.find_by_user_ids(user1_id, user2_id)
    Friendship.find_by(from_user_id: user1_id, to_user_id: user2_id) ||
    Friendship.find_by(from_user_id: user2_id, to_user_id: user1_id)
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

  private

  def cannot_add_self
    if from_user == to_user
      errors.add(:to_user, "can't be same user as sender")
    end
  end

  def alternative_request
    if Friendship.where(from_user: self.to_user, to_user: self.from_user).exists?
      errors.add(:to_user, 'alternative request exists')
    end
  end
end
