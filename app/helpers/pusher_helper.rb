module PusherHelper
  PUSHER_CHANNEL = 'private-miniTwitter-channel'
  PUSHER_EVENT_FOLLOW   = 'miniTwitter-event-follow'
  PUSHSER_EVENT_LOGOUT  = 'miniTwitter-event-logout'

  PUSHER_PRESENCE_CHANNEL = 'presence-miniTwitter-channel'

  def pusher_trigger_event(event, user_info)
    self.send("pusher_trigger_#{event}", user_info)
  end

  def pusher_trigger_follow(user_info)
    Pusher.trigger("#{PUSHER_CHANNEL}-#{user_info[:id]}", "#{PUSHER_EVENT_FOLLOW}", {
      message: "#{current_user.name} is following you!"
    })
  end

  def pusher_trigger_logout(user_info)
    Pusher.trigger("#{PUSHER_CHANNEL}-#{user_info[:id]}", "#{PUSHSER_EVENT_LOGOUT}", {
      message: ""
    })
  end

end
