class User < ApplicationRecord
  # Validations
  validates :username,
    presence: true,
    format: { with: /\A\w+\z/, message: 'can only contain letters or digits' },
    length: { in: 6..30 },
    uniqueness: true

  # Friendships
  has_many :friendships_a, -> { where('accepted') }, class_name: 'Friendship', foreign_key: :from_user
  has_many :friendships_b, -> { where('accepted') }, class_name: 'Friendship', foreign_key: :to_user
  has_many :sent_friendship_requests, -> { where('NOT accepted') }, class_name: 'Friendship', foreign_key: :from_user
  has_many :incoming_friendship_requests, -> { where('NOT accepted') }, class_name: 'Friendship', foreign_key: :to_user

  def friendships
    friendships_a + friendships_b
  end

  def friends
    ids_a = friendships_a.pluck(:to_user_id)
    ids_b = friendships_b.pluck(:from_user_id)
    User.where(id: ids_a + ids_b)
  end

  def friends_with?(user)
    f = friendship(user)
    !f.nil? && f.accept = true
  end

  def friendship(user)
    Friendship.find_by_users(self, user)
  end

  def new_friendship_request(to_user)
    Friendship.new(from_user: self, to_user: to_user)
  end

  # Other
  has_many :posts, foreign_key: :author_id

  # Devise things
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_h).first
    end
  end
end
