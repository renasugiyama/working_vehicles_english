class UserMailer < ApplicationMailer
  default from: 'workingvehicle2024@gmail.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: @user.email, subject: "パスワードリセットのお知らせ")
  end

  def email_change_confirmation(user)
    @user = user
    @url = confirm_email_change_user_url(@user, token: @user.confirmation_token)
    mail(to: @user.unconfirmed_email, subject: "メールアドレス確認のお願い")
  end
end
