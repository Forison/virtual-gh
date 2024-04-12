module Authentication
  class ForgotPasswordMailer < ApplicationMailer
    def change_password_request
      @user = params[:user]
      @password_reset_url = authentication_url(email_type: 'fpm', token: @user.reset_password_token)
      mail(
        to:      @user.email,
        subject: 'Reset Password',
        date:    Time.zone.now
      )
    end
  end
end
