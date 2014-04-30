class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :sender, presence: true, strict: true
  validates :recipient, :subject, :body, presence: true

  def self.new_to_old
    order("messages.created_at DESC")
  end
end
