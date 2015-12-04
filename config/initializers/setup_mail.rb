if Rails.env.development? || Rails.env.production?
  # SENDGRID
  # ActionMailer::Base.delivery_method = :smtp
  # ActionMailer::Base.smtp_settings = {
  #   address:        'smtp.sendgrid.net',
  #   port:           '2525',
  #   authentication: :plain,
  #   user_name:      ENV['SENDGRID_USERNAME'],
  #   password:       ENV['SENDGRID_PASSWORD'],
  #   domain:         'heroku.com',
  #   enable_starttls_auto: true
  # }
# elsif Rails.env.development?
#   ActionMailer::Base.delivery_method = :smtp
#   ActionMailer::Base.smtp_settings = {
#     address: 'smtp.gmail.com',
#     port: 587,
#     domain: ENV['GMAIL_DOMAIN'],
#     authentication: 'plain',
#     enable_starttls_auto: true,
#     user_name: ENV['GMAIL_USERNAME'],
#     password: ENV['GMAIL_PASSWORD']
#   }


  # MAILGUN
  ActionMailer::Base.smtp_settings = {
    port:              587,
    address:           'smtp.mailgun.org',
    user_name:         ENV['MAILGUN_SMTP_LOGIN'],
    password:          ENV['MAILGUN_SMTP_PASSWORD'],
    domain:            'appba90049adcf64a449d9a8b8c24d8faa3.mailgun.org',
    authentication:    :plain,
    content_type:      'text/html'
  }
  ActionMailer::Base.delivery_method = :smtp
end

# Makes debugging *way* easier.
ActionMailer::Base.raise_delivery_errors = true

# This interceptor just makes sure that local mail
# only emails you.
# http://edgeguides.rubyonrails.org/action_mailer_basics.html#intercepting-emails
# class DevelopmentMailInterceptor
#   def self.delivering_email(message)
#     message.to =  'luise.rauch@gmail.com'
#     message.cc = nil
#     message.bcc = nil
#   end
# end

# Locally, outgoing mail will be 'intercepted' by the
# above DevelopmentMailInterceptor before going out
if Rails.env.development?
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)
end
