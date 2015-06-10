class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@colcho.net"
  layout 'mailer'
end
