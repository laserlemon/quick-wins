class User < ActiveRecord::Base
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id", inverse_of: :recipient

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  has_secure_password

  def self.authenticate(username, password)
    user = User.find_by(username: username)
    user && user.authenticate(password)
  end
end
