module CreateActivity
  def create_activity target_id, activity_type, user_id
    Activity.create target_id: target_id,
      target_type: activity_type, user_id: user_id
  end
end
