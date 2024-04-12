module Authentication
  class UserAccountMailer < ApplicationMailer
    def lock_account
      @user = params[:user]
      @account_unlock_url = authentication_url(email_type: 'uam', token: @user.unlock_token)
      mail(
        to:      @user.email,
        subject: 'Unlock Account',
        date:    Time.zone.now
      )
    end
  end
end
