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
end
