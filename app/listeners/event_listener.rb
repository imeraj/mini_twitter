class EventListener
  def user_register(user)
    user.send_verification_email
  end

  def password_reset(user)
    user.send_password_reset_email
  end

end
