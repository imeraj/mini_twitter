class UserListener
  def user_registered(user)
    user.send_verification_email
  end
end
