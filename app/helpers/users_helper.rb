module UsersHelper
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def set_status(ids, status)
    User.where("id IN (?)", ids).update_all(online_status: status) unless ids.empty?
  end

end
