module AuthenticationHelper
  def authentication_url(email_type:, token:)
    "http://localhost:3000/auth/#{email_type}?#{token}"
  end
end
