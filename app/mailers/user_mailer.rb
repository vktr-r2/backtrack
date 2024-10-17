class UserMailer < ApplicationMailer

  defalut from: "placeholder@email.com"

  def password_reset(user, token)
    @user = user
    @token = token
    mail(
      to: @user.email,
      subject: "Backtrack Password Reset"
    )
  end
end
