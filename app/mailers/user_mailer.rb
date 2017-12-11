class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user, token)
    @user = user
    @activation_token = token
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail to: email_with_name, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user, token)
    @user = user
    @reset_token = token
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail to: email_with_name, subject: "Password reset"
  end
end
