class Notification < ApplicationRecord
  belongs_to :user

  def self.create_notifications user_id, current_user, target_id
    Notification.create({
      user_id: user_id,
      content: "#{current_user.name} sent you a challenge in Ruby On Rails Course",
      mask_as_read: false,
      target_id: target_id
    })
  end
end
