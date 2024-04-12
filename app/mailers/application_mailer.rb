class ApplicationMailer < ActionMailer::Base
  include AuthenticationHelper
  default from: 'from@example.com'
  layout 'mailer'
end
