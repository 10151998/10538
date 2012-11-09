class Notifier < ActionMailer::Base
  default :from => "yueying.cui@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.parental_consent_confirmation.subject
  #   FROM: controller/users_controller/confirm_parental_consent
  #   2012.7.15 Yueying
  def parental_consent_confirmation(user_id)
    @user = User.find(user_id)

    mail(:to => @user.email_parent, :subject => "parental consent confirmation")
  end

  # parental_consent_confirmation
  #   INPUT: user_id (session value)
  #   FROM: controller/users_controller/forget_password
  def reset_password(user_id)
    @user = User.find(user_id)

    mail(:to => @user.email, :subject => "reset password")
  end
end
